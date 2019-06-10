Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91683BD5C
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2019 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbfFJUNp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jun 2019 16:13:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:62280 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389099AbfFJUNp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 Jun 2019 16:13:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 13:13:43 -0700
X-ExtLoop1: 1
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2019 13:13:43 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Jun 2019 13:13:43 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.84]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.28]) with mapi id 14.03.0415.000;
 Mon, 10 Jun 2019 13:13:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Marco Elver <elver@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "jbaron@akamai.com" <jbaron@akamai.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] EDAC, ie31200: Reformat PCI device table
Thread-Topic: [PATCH v2 2/2] EDAC, ie31200: Reformat PCI device table
Thread-Index: AQHVH8DCN8lFS+IPpkmN4EljuqvIIqaVUanA
Date:   Mon, 10 Jun 2019 20:13:42 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E996B42@ORSMSX104.amr.corp.intel.com>
References: <20190610191422.177931-1-elver@google.com>
 <20190610191422.177931-2-elver@google.com>
In-Reply-To: <20190610191422.177931-2-elver@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDVkZDcxZjctOWMzNC00MGY0LWIwZjAtY2ZjY2Q0YWU4NzMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTFk0XC9ZRDV2UWUxMGZPNTBLckt5Y0JYRXJPK1FYdVg0Um5VNmVPY3NGOWZcL1wvYTc5YmhPZVBaY3UraDNlSThcL1MifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBSZWZvcm1hdCBkZXZpY2UgdGFibGUgYWZ0ZXIgQ29mZmVlIExha2UgYWRkaXRpb25zIHRvIGJl
IG1vcmUgcmVhZGFibGUuDQoNCkkgbGlrZSB0aGF0IHlvdSBwdXQgdGhlIHJlZm9ybWF0IHNlY29u
ZCAuLi4gaWYgc29tZSBvbGQgdmVyc2lvbiBuZWVkcyBhIGJhY2twb3J0DQp0byBnZXQgQ29mZmVl
IExha2Ugc3VwcG9ydCB0aGV5IGNhbiBqdXN0IHRha2UgcGFydCAxIHRvIGdldCB0aGUgZnVuY3Rp
b25hbGl0eQ0KYW5kIHRoZW4gZGVjaWRlIHdoZXRoZXIgb3Igbm90IHRvIHRha2UgcGFydCAyLg0K
DQpCb3RoIHBhcnRzOg0KDQpBY2tlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29t
Pg0KDQo=
