Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A29AA42C
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2019 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfIENRt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Sep 2019 09:17:49 -0400
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:64480
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730710AbfIENRt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Sep 2019 09:17:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LugVw+ErNzTihH5l6hpYt82NmWv2wSUINnMPE0l6QRj55a40vNc9tcqCdsN9LMQoWx69ve1w6tQCOXDYpPOefOj7XoWRiKe+IxgDL9hM14esPaq+emF+OtBzAWfQrijaHo1Z+Lxu0gvAwOo/a+BpTJpIc4bRvjTbAVsQ5IQo6mItRHHBNtQigeoARDAbjH9y9L1Bg3u6B+H355AUOEMMPozm7GUCFkqcSIFJa13DTf93CBep5GESR8pcpM/2lNn5c/wTJug8EF2UXgxqqmn46IWKecd31S0jsTDrhhEgVALQmR8VjyZANQsXNR8cgFvAvBYSP3BUUfY4pURHqBA3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiNykVllcW8Vmay8Qr6OIU+vlbG+frf+eFXQG+ZFxo0=;
 b=nD8csLhu7BE4cNDcODslJhY4LHqn/V5iqknfmj/2kQknfLt5h7PAIdNPmrER1ooEkYbmj+62A7FCzB2mDmm+ymMXHSykYmHXN8Xpj/KFxwaDYnyFRku/YtoemtYUT6SaH8xRCFbOHT6Ox6RFTpxruaxDjwDTuh7D4L1dZrbQhex6xaOJqP5fX24gjgGX2XZFJncChleZkb8ydtchC9JWh5OKnUpTdA68cdcq1VnBarqrGXc+THtr4jXM2VLC/w1cSND5XpgHG2M+FENU97xnIkN7lQGmu26DHek4YbkKIvh4UF0y/ppO7p1m+7B/MWt2FPAXEkWVwPc8rwEQSabHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiNykVllcW8Vmay8Qr6OIU+vlbG+frf+eFXQG+ZFxo0=;
 b=TVyRTsFN9T0FoGzgApZlI81Gwvfbw0ZiO44EjkmkLsWLWGuStBKJD8lCCfgABlsTPNk0H7+MnXu/aOLetllR779HL5uFzPHg4Furh+WKhhldm7f2oSwMOEFzExd62jrUgFssqDAUepegsvP8XsuScVfMoaVuSxiinZF5AIYL8Jo=
Received: from BN7PR07MB5186.namprd07.prod.outlook.com (20.176.176.155) by
 BN7PR07MB5346.namprd07.prod.outlook.com (20.176.27.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Thu, 5 Sep 2019 13:17:46 +0000
Received: from BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f]) by BN7PR07MB5186.namprd07.prod.outlook.com
 ([fe80::682e:801a:5227:668f%7]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 13:17:46 +0000
From:   Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Topic: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Index: AQHVY2RbCb5+3YDIEkuYe/75JNXLCKccD30AgAA0MwaAAGcwgIAAZrkK
Date:   Thu, 5 Sep 2019 13:17:46 +0000
Message-ID: <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>,<20190905070917.GA19246@zn.tnic>
In-Reply-To: <20190905070917.GA19246@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=isaac.vaughn@Knights.ucf.edu; 
x-originating-ip: [132.170.59.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce82e56a-4caf-42ff-7278-08d73203718f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR07MB5346;
x-ms-traffictypediagnostic: BN7PR07MB5346:
x-microsoft-antispam-prvs: <BN7PR07MB534611FCF4132686ECD954E3CEBB0@BN7PR07MB5346.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(486006)(33656002)(7696005)(76176011)(446003)(25786009)(478600001)(3846002)(52536014)(6116002)(7736002)(44832011)(9686003)(186003)(5660300002)(4744005)(26005)(66066001)(4326008)(476003)(6246003)(6506007)(6436002)(88552002)(256004)(2906002)(102836004)(6916009)(55016002)(8676002)(86362001)(81156014)(71190400001)(71200400001)(229853002)(66556008)(66476007)(64756008)(66446008)(54906003)(786003)(66946007)(53936002)(316002)(75432002)(81166006)(8936002)(11346002)(14454004)(76116006)(99286004)(305945005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5346;H:BN7PR07MB5186.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: Knights.ucf.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 81FEs9EXrbeIi5A/ylmbLUL6sJwlhs3ItxTYqLejDacV5OCZ25IZJdgbBcy5uWzpYAU8ztygzGhip86aensVcextB5wStlHhJg5x2KxHZ2selIDEvpciqlCa+xvGu+eaQ4mQ38G8jAz1NekL5TdGcLT6+3SkOENUW7QRgnvUAb7iuneOJI+X07471MH00b2RHqpHMJ37hZqAlxALu6AppV7deBrM/AlosKt0gQ8RcQLI6BYI7xAVq+F6M2kR/ymaIIZ969MC166sw6bRavRgVBHIQJQnMAminGeYWPtopW0+S2fbQNvS3JhAYcf2YP32PLQkgv60r1mFWHrEmGzkJZzM2W957KGXaaq451DMvkwdCTGrfICR7mu/gsYCXo2wyz2UMM0jwFfbCQfKiTqrjIkSkCHXk0WVLxvA4Abiosk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ce82e56a-4caf-42ff-7278-08d73203718f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 13:17:46.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xVFonufrMANXXbzF8Uzs38p9ny923TmfaJCULdz8xYs9jPkiYH2oB6/n8AQuJq+3Iids0JRnwa33vChfSMmkUROMpDNT7THXUDBeOXvGB9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5346
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

 > Oh, and pls add those PCI IDs to drivers/edac/amd64_edac.h, not to
 > pci_ids.h because they will be used by the amd64_edac driver only for
 > now so they don't need to go into the system-wide header.
Does this apply to all the PCI IDs? Functions 0 and 6 are in amd64_edac.h, =
but some of the additional IDs had model 30h equivalents in different place=
s. For the additional IDs Yazen pointed out, I imitated the changes from co=
mmit be3518a16ef270e3b030a6ae96055f83f51bd3dd (x86/amd_nb: Add PCI device I=
Ds for family 17h, model 30h).

Sincerely,
Isaac Vaughn=
