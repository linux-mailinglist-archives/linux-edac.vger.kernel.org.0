Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7810664AFE
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2019 18:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfGJQyu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Jul 2019 12:54:50 -0400
Received: from mail-eopbgr760045.outbound.protection.outlook.com ([40.107.76.45]:42695
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbfGJQyt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 10 Jul 2019 12:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DULPBir/+tYkMTON1UL0p3b0ZZBg3xd6kFdzJuQJsB5vex+wlcGTrhHfglTQXja+t2TWzkdOYEKDGv/LC1g3E2MxXFe9Jxqj2ObdqHFoz3PFQETYNe0v3J/9DdqKymwSHzKAq++2fc09KwmRMiG1EjOpjLQoFCXdDsgYhS2vXzQ2Y3hYNm7kAAEXsvy2aPTR/xaCfkIgBO9Y/lg9TfxFZ6txxAY65ORyfbLA+jo1RZ4wmbas8PdaVgHzzmB9hcaPRfMjz/XPIh3WAJidb7kAABEpu3d7edGMERn/amH+8e+rold+G9I0xVH4PqxJ/6EWj9f/eev7PFqKXKeefKh6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hcg2xkKO7S8bjYqExqHRrS5JpU1ZC/lBganHueQipKQ=;
 b=LDg8yuNEcmJOZwN+txjPSq81bs/HkigtgSiNS39ynTwSpEASmFLfQOq/c1lu9NHlSUfbGa+nY0S/AAwqaQJRR73M9EKWXO+3wekM2TNEHLwOoE9IG6T+i/L/54PLpHbaSueEGrt7AN9pfQqEXDMCXdFMcl36THj41SfMks73ROoO87E8HU7bBu4n7HqM1YOc/TaKW4DAiQWi1adM4QTSe/uNQrFE8qB+RPBoPXNan+I9pRReBJgNmonyFvwtCdb+oYO03Q/xPlbS9VD9+bd7moKV2s65687FZ22OHjiZaeu54DiiHW7GuzZ4f5Uz51HyuMHSM53TeBxL60rvneIuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hcg2xkKO7S8bjYqExqHRrS5JpU1ZC/lBganHueQipKQ=;
 b=NTXAJ/2AU2D+yHOcJ+Z7uBOHNgQdyi67zTmtHlVhNsoYNvQW+Tl8rUprYNasNfZkr/iEkfMbARJn4HrJfSzX/ZMvrfZxqgjegsEe+NOnUvm6CQijQIVaz9Rpx4SEwFqkxZQeUkPJtAaClMn3diJqA5sLQBCItTl/idhhe2RLqhc=
Received: from MWHPR12MB1806.namprd12.prod.outlook.com (10.175.52.149) by
 MWHPR12MB1758.namprd12.prod.outlook.com (10.175.53.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 16:54:45 +0000
Received: from MWHPR12MB1806.namprd12.prod.outlook.com
 ([fe80::2932:24d8:8742:e62a]) by MWHPR12MB1806.namprd12.prod.outlook.com
 ([fe80::2932:24d8:8742:e62a%2]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 16:54:45 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v2 1/7] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Topic: [PATCH v2 1/7] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Index: AQHVN0Asc2CazzfP60GUzjiUo3pGLA==
Date:   Wed, 10 Jul 2019 16:54:44 +0000
Message-ID: <af8c4e5e-d1c1-b733-9303-014314aec9d5@amd.com>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
 <20190709215643.171078-2-Yazen.Ghannam@amd.com>
In-Reply-To: <20190709215643.171078-2-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To MWHPR12MB1806.namprd12.prod.outlook.com
 (2603:10b6:300:10d::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ede45b6-e7f9-4a75-9786-08d705574f45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR12MB1758;
x-ms-traffictypediagnostic: MWHPR12MB1758:
x-microsoft-antispam-prvs: <MWHPR12MB1758EF86B2D73DFBD857034087F00@MWHPR12MB1758.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(189003)(3846002)(14454004)(8676002)(6486002)(6436002)(6116002)(52116002)(2501003)(8936002)(4326008)(26005)(5660300002)(2906002)(25786009)(256004)(6246003)(53936002)(66446008)(76176011)(64756008)(31696002)(66476007)(66556008)(229853002)(66946007)(81156014)(81166006)(6512007)(186003)(66066001)(54906003)(86362001)(110136005)(71200400001)(71190400001)(31686004)(478600001)(102836004)(486006)(316002)(305945005)(7736002)(446003)(11346002)(68736007)(386003)(53546011)(6506007)(36756003)(476003)(2616005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1758;H:MWHPR12MB1806.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pa9J3ZWM7CjaBIbDGWuKpDyvncEQouLtqDtBEhf/P35JRP0TpxAeMFymNO1cil0yQ2QQSSHOPnz9XGUgQEfFIddRiZywWnmFjPHxa00Lz12pOEvQ80HqdvF2Yp+hdaOj7pUlQy7VaselJczAiXFBL8Stxi/fk/xhIyjthTxqXZ0dkLWAFtH5duC3v/9r8vgAS35jRaUQR5Cx+tlvFrjBMLs8tBQjSQI6SHh9UwC46lJJk/w7m3B3wyR6NWVBj0D4xIKAS6LTAP9LvIXf67Lwx/W64LFjXlgPua5O8AFfnm62c8wxjeEjzyOSYicFmRVIIFUpiMDKlzXwNkl/b1fqrlmLzVyKMQinYGg3Cj7IujZRr1RwKVYOmr7nPfpSkLuacNtTmrd9U9Crrq4AD5ArbE6WlPatfoe6GUPkrKmQaFM=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5B6D0F510AADE5429747A14E82A53C05@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ede45b6-e7f9-4a75-9786-08d705574f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 16:54:44.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kphillips@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1758
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 7/9/19 4:56 PM, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> The struct chip_select array that's used for saving chip select bases
> and masks is fixed at length of two. There should be one struct
> chip_select for each controller, so this array should be increased to
> support systems that may have more than two controllers.
>=20
> Increase the size of the struct chip_select array to eight, which is the
> largest number of controllers per die currently supported on AMD
> systems.
>=20
> Fix number of DIMMs and Chip Select bases/masks on Family17h, because AMD
> Family 17h systems support 2 DIMMs, 4 CS bases, and 2 CS masks per
> channel.
>=20
> Also, carve out the Family 17h+ reading of the bases/masks into a
> separate function. This effectively reverts the original bases/masks
> reading code to before Family 17h support was added.
>=20
> This is a second version of a commit that was reverted.
>=20
> Fixes: 07ed82ef93d6 ("EDAC, amd64: Add Fam17h debug output")
> Fixes: 8de9930a4618 ("Revert "EDAC/amd64: Support more than two controlle=
rs for chip select handling"")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---

For this and the rest of the series:

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
