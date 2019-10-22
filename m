Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1231AE0D4F
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2019 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbfJVUfR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Oct 2019 16:35:17 -0400
Received: from mail-eopbgr760059.outbound.protection.outlook.com ([40.107.76.59]:62979
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731351AbfJVUfQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 22 Oct 2019 16:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxZfxsR/3K3wII/CfubZ8BUxZfVVF/NwwaECMtI2vGbBeue1rXLw4Q31keTQ7g/rRPNGDGJPYs87XwSjMtSW2r9Y7Se5dAPEowyNF/uSkVKKkDZff2w9aI0prt11Clw2Qz1DRuh8taL8ZBQkxHjlXyjQdbiiH7c4PsQ+K72qnlezNNEKOTBRyR0Y1iRcsrMRdK+0vgdP6kwvWKJELnM3of6s1Hqz+xAnjkxLFuHKFvjM/EKGAT1wJVaRnH+oX4OC4U/pKianNyk6FBJINRJEWxMMjKfumYKM7wLsXt5aVu0Jz6p5ChIsm4eT879qGgDr8V4qKFJShTGTgYGDq/YCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB/8tcRui2wHVa3f2dyELvitwmW4G/UU4Y5rW0Sv9m0=;
 b=R5bS8SXvLJUFuS3I3bJxSLPKk5UaDNRwczIvOHpk0IIqEt6nAzaZPet14lUY3kkjVoWZrU3i0BqkR+3BoEeKK9Viw6lGEwiVW4TUJm7KThmvxWGOLSDRqMQt7kjRn+JiAaYsxh4NKj/qPXMd3EomrLReWOnHr9AeJRWA1z28kJGb6fNcQL8Kk/2jAWMN1WmhvarSsWzgAj4NsPFYoSysgYq0FCavT8JKteIrcCyf9QbDlWV6uSIKIflBr6eC+8uGuCgUVRTHNCU/Y1Wi1O2lilahA8xx/ssfPspKT97LzcPSxrvOIGUPVqw8raijaNSJgGX2SWkJvNIAAhFm2LrCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB/8tcRui2wHVa3f2dyELvitwmW4G/UU4Y5rW0Sv9m0=;
 b=krr29fq8HXtyj6fQc6w9CBP/rMgEDVXAt5COu/cNPswOq+dcXkoeJW0i/+M7P5+Nj/OPFVZ4gXeAePsVKOVm2ewees1J/FmNwLDDx3bw47lmSz5Z7UBmej1g19mUfBlNEGyTBb5g/2rJcxcJO8RWmPmmhvI88qqVLvhZkh11X3g=
Received: from BN7PR12MB2628.namprd12.prod.outlook.com (20.176.178.20) by
 BN7PR12MB2723.namprd12.prod.outlook.com (20.176.177.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 22 Oct 2019 20:35:09 +0000
Received: from BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a]) by BN7PR12MB2628.namprd12.prod.outlook.com
 ([fe80::2115:dffc:44b6:e53a%6]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 20:35:08 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHViRgxcQiEBlwrekGL67NfTPIxZg==
Date:   Tue, 22 Oct 2019 20:35:08 +0000
Message-ID: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0024.namprd05.prod.outlook.com
 (2603:10b6:803:40::37) To BN7PR12MB2628.namprd12.prod.outlook.com
 (2603:10b6:408:30::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a171a99e-0d2e-47e9-de20-08d7572f5431
x-ms-traffictypediagnostic: BN7PR12MB2723:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR12MB2723328A32376E21175BD687F8680@BN7PR12MB2723.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(6306002)(476003)(2616005)(26005)(102836004)(186003)(966005)(6436002)(81166006)(81156014)(52116002)(99286004)(50226002)(6512007)(486006)(8936002)(36756003)(6486002)(305945005)(8676002)(7736002)(4744005)(2501003)(14454004)(5660300002)(478600001)(4326008)(25786009)(2351001)(316002)(2906002)(54906003)(6116002)(86362001)(256004)(66066001)(1076003)(5640700003)(66946007)(6916009)(6506007)(66476007)(3846002)(66446008)(71190400001)(71200400001)(64756008)(66556008)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2723;H:BN7PR12MB2628.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qGiPl+pW6OSsbTd0WGwLTa0+JjxOAI+f3S91iVgx06FeT4/hObOCgnr9/2N7UBL73GUimPID3TXHdQ0NL9pg3jBhYvJqriOqxHN0MszIYW/7ApahQaHW/ShIVV5DhcUhz+UoaFAll4DjHNERtkQn8J4ksOd7H/4s6KU9K+RasWlxwb22A/jqB5AcaqGPBp1NnF3xdYVW04XOPwvMIO5ASqIJoyFeXBdMsbFpUBoK+zo9CIMYY3+85wuyffb2i+AgSqhkw6uG44tiYdMsMkKhWHLvP2KCJZ8wTcQ9VyG+Xm+feYjcxwp6r/6Fb/YhXLvYyHegw9NrSjShQgBI1T+YHPuYqNNSgCA6DE9A/UZPI8cQaTwQVbXPfrEFV672zo9zWnRZSfBkxxGFso04uOEtk797wrayNHIhG+9nr4PQy4nLsJRrbp9k4B1LIakjI4JMwsLOlQuvLGY4E+9yNDPJYYgczaloxNJVZj536qtNw9w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a171a99e-0d2e-47e9-de20-08d7572f5431
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:35:08.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aGNt+5fmrzrq7Cizyrp16wmUEJFzC8pXxQlB6huDYGFjr0oJ1dlYeTyyEL6XLaySERXp9A+5ElAIj7YEfJ44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2723
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Boris,

Most of these patches address the issue where the module checks and
complains about DRAM ECC on nodes without memory.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20191018153114.39378-1-Yazen.Ghannam@amd.com

Yazen Ghannam (6):
  EDAC/amd64: Make struct amd64_family_type global
  EDAC/amd64: Gather hardware information early
  EDAC/amd64: Save max number of controllers to family type
  EDAC/amd64: Use cached data when checking for ECC
  EDAC/amd64: Check for memory before fully initializing an instance
  EDAC/amd64: Set grain per DIMM

 drivers/edac/amd64_edac.c | 196 +++++++++++++++++++-------------------
 drivers/edac/amd64_edac.h |   2 +
 2 files changed, 100 insertions(+), 98 deletions(-)

--=20
2.17.1

