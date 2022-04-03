//
//  AuthenticationError.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 11/04/22.
//

import Foundation

enum AuthError: Error, Equatable {
    case incomplete(Set<LoginField>)
    case invalid
    case notFound
    case networkError
    case unknown
}

extension AuthError: DescribedError {
    public var description: String {
        switch self {
        case .incomplete(let fields):
            let fieldString = fields
                .map { $0.rawValue }
                .joined(separator: " dan ")
            return "\(fieldString) tidak boleh kosong"
        case .invalid:
            return "Username atau Password salah"
        case .notFound:
            return "User tidak ditemukan!"
        case .networkError:
            return "Koneksi gagal, mohon cek kembali koneksi internet anda"
        case .unknown:
            return "Maaf, terdapat error yang tidak terduga. Silahkan coba kembali"
        }
    }
}
