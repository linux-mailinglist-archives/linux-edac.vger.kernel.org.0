Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE203184F
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 01:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEaXpT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 19:45:19 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:10724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726856AbfEaXpS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 19:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXW8gx1LfT3qRS4Qi3YJiiN5fSVyTc43mfnFv7sMBvo=;
 b=DCMLWwRmQtIIw/WXF+ulCvHZhBb58R4GhOLyv5s7HuScpxIj6MnIY9mIul1i7nGvpfbDSvylZrXMPH5RUfpsgWfE87XOx12U31epRFnAxDQCSMD/x6+BGcRcF5nQb/agPEZHNHL2TP5KZi2yH2ZnxNkyxyjBlqgflJ25XYJ71CE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2671.namprd12.prod.outlook.com (52.135.103.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 23:45:11 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 23:45:11 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 0/8] AMD64 EDAC fixes for v5.2
Thread-Topic: [PATCH 0/8] AMD64 EDAC fixes for v5.2
Thread-Index: AQHVGAriIzsx/roGdE+8t90RFk6RUw==
Date:   Fri, 31 May 2019 23:45:11 +0000
Message-ID: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:805:de::45) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fac2f83d-da41-45e2-139a-08d6e6220519
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB26716246DC8E93A9AB7454C1F8190@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(5640700003)(25786009)(6506007)(256004)(72206003)(2906002)(54906003)(6512007)(14454004)(186003)(86362001)(3846002)(6116002)(486006)(2501003)(71200400001)(6486002)(386003)(2351001)(478600001)(71190400001)(52116002)(36756003)(6436002)(26005)(68736007)(6916009)(99286004)(66476007)(476003)(4744005)(73956011)(66066001)(66946007)(2616005)(81156014)(305945005)(81166006)(1076003)(8936002)(316002)(7736002)(4326008)(8676002)(66446008)(64756008)(50226002)(53936002)(5660300002)(66556008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wAUsVyJ+62W65mJ/4fl1TNoO01owN7FItsA86U65PIxAgUYb/FsrX7gTrFORSoTk/Y0H9jMX8yXWIajdcHP8lmZpEDWk+nJnqceiyls/Dn63KDhRLqsHrJrw4TNFxgByH5VDPDgDRzodOFLpBHb93bPIM4glhR40CIycMw9VQpczThPnjamRhElToIJeHNgMh75ArwiEpVMeE80La6Kf7s5ZwVlmROKOstBx/ZOHIC5kofVDtwCjrrDyI+bIsjy0F8dJ4+Z+m96pxySWO/QWbFJfGwOn6BZaaBYPrsmOL07LJaITA+lcSU7AjAZRRab+DGOssDKMB860TFd+AdwMCgMcY6WFwETShtPNeH/x8H2Z6TUEZj3PmEMpkkpqjnCsWG5orb4rqyyMLQgO1JqivNDZ+bVSqyoOrrDoxaEbW5o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac2f83d-da41-45e2-139a-08d6e6220519
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 23:45:11.1298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpIaSBCb3JpcywN
Cg0KVGhpcyBzZXQgY29udGFpbnMgYSBmZXcgZml4ZXMgZm9yIHNvbWUgY2hhbmdlcyBtZXJnZWQg
aW4gdjUuMi4gVGhlcmUNCmFyZSBhbHNvIGEgY291cGxlIG9mIGZpeGVzIGZvciBvbGRlciBpc3N1
ZXMuIEluIGFkZGl0aW9uLCB0aGVyZSBhcmUgYQ0KY291cGxlIG9mIHBhdGNoZXMgdG8gYWRkIHN1
cHBvcnQgZm9yIEFzeW1tZXRyaWMgRHVhbC1SYW5rIERJTU1zLg0KDQpUaGFua3MsDQpZYXplbg0K
DQpZYXplbiBHaGFubmFtICg4KToNCiAgRURBQy9hbWQ2NDogRml4IG51bWJlciBvZiBESU1NcyBh
bmQgQ2hpcCBTZWxlY3QgYmFzZXMvbWFza3Mgb24NCiAgICBGYW1pbHkxN2gNCiAgRURBQy9hbWQ2
NDogU3VwcG9ydCBtb3JlIHRoYW4gdHdvIGNvbnRyb2xsZXJzIGZvciBjaGlwIHNlbGVjdHMNCiAg
ICBoYW5kbGluZw0KICBFREFDL2FtZDY0OiBSZWNvZ25pemUgRFJBTSBkZXZpY2UgdHlwZSB3aXRo
IEVEQUNfQ1RMX0NBUA0KICBFREFDL2FtZDY0OiBJbml0aWFsaXplIERJTU0gaW5mbyBmb3Igc3lz
dGVtcyB3aXRoIG1vcmUgdGhhbiB0d28NCiAgICBjaGFubmVscw0KICBFREFDL2FtZDY0OiBGaW5k
IENoaXAgU2VsZWN0IG1lbW9yeSBzaXplIHVzaW5nIEFkZHJlc3MgTWFzaw0KICBFREFDL2FtZDY0
OiBEZWNvZGUgc3luZHJvbWUgYmVmb3JlIHRyYW5zbGF0aW5nIGFkZHJlc3MNCiAgRURBQy9hbWQ2
NDogQ2FjaGUgc2Vjb25kYXJ5IENoaXAgU2VsZWN0IHJlZ2lzdGVycw0KICBFREFDL2FtZDY0OiBT
dXBwb3J0IEFzeW1tZXRyaWMgRHVhbC1SYW5rIERJTU1zDQoNCiBkcml2ZXJzL2VkYWMvYW1kNjRf
ZWRhYy5jIHwgMzQ4ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQogZHJp
dmVycy9lZGFjL2FtZDY0X2VkYWMuaCB8ICAgOSArLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMjMyIGlu
c2VydGlvbnMoKyksIDEyNSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
