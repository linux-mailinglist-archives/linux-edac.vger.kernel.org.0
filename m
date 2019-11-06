Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326A5F0B9D
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 02:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfKFBZC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 20:25:02 -0500
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:36833
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729614AbfKFBZC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 20:25:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzxlHGmAkyhMd0k/eQudJ1133dyrRR7zStrJjss6DncOASD3JgDS0Tz9p4oq2NIVFLVFim0qmbP+5ygcA1U5GrWURr0UadfFAUWWPSNpP1QobK9wr0P0b8MPDnA8v9GYisTOZUAaRLs+3Q/KOcOjzfeRchwUOWADMkxgk3a3eKvpenUuoQcROP7+jaRVQEBQSprV2ApGoet7hyEUQ83hpB0zwfp5izCHYIPhhGvgy1VN0izCmkL+2LGZjJ5jnhfybrBqnI1Kb5bjxEUDEjs2xHu1Jrl6tGwU68Vkp+xkD3d6lR2IiCvpIWBYoiiDxdHzscHboDQ5e9E5kMv3z593eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfZZlLC1GaolrthWLsWfBce1z4UYwyRfPAAIgv1ezr8=;
 b=Lf1RnztAhPTtZ19TIWTu4568eAEsQ+cLkYeFv8ctL4KgOr8wnXxsihq9RWz8Tf0mqZ6wA6mgm7IQt/3K5ekSCQcdeWZnXrt92rogBO2/flgFKOD1RvslBWX7MNeXpIUEDhorjLZPsrpf30tjvF1SIL/hnICzIui9A30TbNgnBSYG4fcfRyN1oxMfttg3kdmpG5rvWpDqxww57n8lf7HE93UnMz/b1VuLgHE/3b7Fu8RC5xHp4PR68IuhT5BLu4F77Z1gNEpQcgQjMbsgWxE3psmCkVEz6NTER/nEqJkw0Wr6Soa35JXjnnprXda+WAXqE1RAEvl7sG7kvEU6t4juSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfZZlLC1GaolrthWLsWfBce1z4UYwyRfPAAIgv1ezr8=;
 b=inPdGsTZYwWgoi5VJm2FDGilOSM4aBAkeG0uAWtcSyPV11IBvd54mOlsOrat1isZB0C+4eWeQ7NUFjglQliBAabuBaEwH89GmWUvvZWjIOTNarNc8FGGku+IXMcPz7rBVHzlpNMxx1D/UelEocLX4mJGPmUmP3XgFw2SLaHG1NE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 01:24:59 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 01:24:59 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHVlEEBkkiHg8UvLEKx+Q/uzElWBg==
Date:   Wed, 6 Nov 2019 01:24:59 +0000
Message-ID: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:802:20::35) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d79883c3-615e-4675-6a99-08d762582386
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB27839A7E8E7F3B6DA20C19E5F8790@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(186003)(5660300002)(86362001)(386003)(4326008)(102836004)(6506007)(1076003)(52116002)(966005)(6306002)(2906002)(5640700003)(99286004)(6116002)(36756003)(54906003)(14454004)(25786009)(4744005)(486006)(66556008)(81156014)(6916009)(305945005)(7736002)(26005)(6512007)(2616005)(66066001)(2501003)(66946007)(316002)(64756008)(478600001)(50226002)(71190400001)(71200400001)(81166006)(8676002)(256004)(2351001)(8936002)(6436002)(476003)(6486002)(66446008)(66476007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8kNFiK5x9oGlRN22S2TEmOrIIhH71PlAkl6te2z5et3atL1EXTPMLvbaOKZK8qDoUlQNjYHSLosgECGMMlbowPP5xKpk2kveS6/EmXbJ+KkKatesYGiMp3976CsAqFITuLH3ZT0cyXx7IpnyFZcEzI5F3cSt3KyxPu+/bSyYEMjOeblwnn7ZS1SqhKiP5be83HbwZotOtVLiW+HtqJU7wafd9KdrUB2PgISbwWWTpHosNtoNaV1MT67H1K9cowZDduXZETffQchRKeD8jrWNqEDL2XxM8FWPu50Y9v/nmj/pvdi6rJ9aY4D95kbpzQJ+KF08VoWO+o6GaV777IYqkXwo/GXJ6pLo3AadC2if1yhEEV/7sbqPd3XQXliYkM4snzklPdTE3Rqvk23EU9Qm9JMrBaM5TCC2ftgOjCoRmm/YBXb98NYA781CMCAF4HOpPxSq74n0jOgCwN1uEPkZQyfU4rEcOINSWbJgIkdvKE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79883c3-615e-4675-6a99-08d762582386
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 01:24:59.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZINDXTHtvHSL7h2FEMXGVhUm+1jtnmk1BRpdydnuf6mJ9lA49Pi2/dl0a3Q8dD9x8mm4R856f9CXsvQHxM8AJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Hi Boris,

These patches address the issue where the module checks and complains
about DRAM ECC on nodes without memory.

Changes from last revision:
  1) Dropped patch 6 which was for adding a grain value.
  2) Added an error code for !ecc_enabled() in patch 5.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20191022203448.13962-1-Yazen.Ghannam@amd.com

Yazen Ghannam (5):
  EDAC/amd64: Make struct amd64_family_type global
  EDAC/amd64: Gather hardware information early
  EDAC/amd64: Save max number of controllers to family type
  EDAC/amd64: Use cached data when checking for ECC
  EDAC/amd64: Check for memory before fully initializing an instance

 drivers/edac/amd64_edac.c | 196 +++++++++++++++++++-------------------
 drivers/edac/amd64_edac.h |   2 +
 2 files changed, 99 insertions(+), 99 deletions(-)

--=20
2.17.1

