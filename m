Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68C128F0D
	for <lists+linux-edac@lfdr.de>; Sun, 22 Dec 2019 18:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLVRXL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 22 Dec 2019 12:23:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64344 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbfLVRXL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Sun, 22 Dec 2019 12:23:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBMHIKJE012803;
        Sun, 22 Dec 2019 09:22:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8lEftprU8rA/Mu5kS3t3a31/iUZFMagezPXUP95m+5E=;
 b=SRiSd19kcPASHd6W2iVnQNrwVoKcEYy03ufo52eRKvWW0RPcXEvQGuYd6y2XzSyMEAFM
 Q4QWIBeWRX8p6gvfEC1CzS0iJeL0N7gCX2NXUXN8jQ3UGP0F+6VAdvFpXb644fO/VjTi
 FjrXqLv1BniH5OwEMWoITlBf4pyRB73o3bqizS5mtWY3PTxOstRD0tOgtAyFpywrl77D
 0k1R42qgHzqRVnHO61FHw2AgleNMpq3Z4h5mC7g0fuXYAh0zRCGzazE3t0QD4V7xofuc
 B0Q3UVotwOXBP1y/saf1P2/vw34n25S5QqifDcXNM3xtMFVmC8199VkyA/yUbF01nsW3 WA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2x1hmv2uab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 22 Dec 2019 09:22:52 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 22 Dec
 2019 09:22:50 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 22 Dec 2019 09:22:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bd1yjgWz9ptKOI5MCZBjMRD3tcDYQxLoSA7R+1DBzCb181d6lipHLpF++iKjE7gvvyBXC3aM1jPe2eOzBQl43/gszadgp9fkaGHxxXZZc3wMSv3vNOq1ZrJ9/HxUHtB7DMN7MnL/Rao9lzavLnnEMi+Alx97HvF6bUpUdavQy6hWYxX9ifGPKvb6UpxRIfi60Tuyaa/UjE2vW2w4gPCLpj80QS8IdbK331JA3AXXUgDlj1VQ7zyyXsyBDvbRDVOnlQee7tnEZ4UfvaAJykbxq9+tllm/ngjnWeXhNLlpCVu3w9Q8V3CplRRSPexZzRudNHGJtUWaI99Yl1N3Ky8Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lEftprU8rA/Mu5kS3t3a31/iUZFMagezPXUP95m+5E=;
 b=SPKVNw45pO13pZKPHWmGvzZG/rKH08ttFt0NumDC2r/jr1PD7KT7C3wyWW6S+aWpNkOLqKLT8090YGyY/+ejPr1ZqViY84yo3UqyUdCICA793v69kT/AgEgwmaws9UT6VgU0Eix8x6NftgpVIcTqhAS38hkcUAnl5v72S9rg+EpcFqf/8RAzgld/4NI9hkFFjSJBmiknUchsTr5FwVDVa/IHY5gfLIRG97Lx+m4QWVwAo/wAoOg5Cn6tKNRqM8hvjYUJ8AMmPkLzCTjbAj1SlmNJ8P/A9DyM9IfyM+CIsGMkMKnX0AMGCsffUitbfe2RI0+XPdsweDJZAtEsvfWVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lEftprU8rA/Mu5kS3t3a31/iUZFMagezPXUP95m+5E=;
 b=TjctS2oo6YxSv8vwQcPjFSucGTsZe0GLuKXWX4GY1t51vmpU8QGR5uVF9rHSyfkqJjSwVpTbiQ0FJ9G1/fWleQAypo6uL5NiqVjI8L0cLW66zPvM+cw/Fm4pDLa8AWhaEoP+TjNSr0MwVvJfgeDzVXcVyodnDXo2tMAUaRYzQ00=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3053.namprd18.prod.outlook.com (20.179.20.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Sun, 22 Dec 2019 17:22:48 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::b96d:5663:6402:82ea%7]) with mapi id 15.20.2559.017; Sun, 22 Dec 2019
 17:22:48 +0000
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0194.eurprd05.prod.outlook.com (2603:10a6:3:f9::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Sun, 22 Dec 2019 17:22:47 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Topic: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Thread-Index: AQHVuOxuJoJ1JfG4w0+V86tO1SdYHQ==
Date:   Sun, 22 Dec 2019 17:22:48 +0000
Message-ID: <20191222172241.t7kquivbvawlbhx6@rric.localdomain>
References: <20191218062129.7400-1-rrichter@marvell.com>
 <20191222121500.GA5485@zn.tnic>
In-Reply-To: <20191222121500.GA5485@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0194.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9af29b9-e10c-4b68-835a-08d7870390ec
x-ms-traffictypediagnostic: MN2PR18MB3053:
x-microsoft-antispam-prvs: <MN2PR18MB3053AAE7DA23AA72172A4032D92F0@MN2PR18MB3053.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(136003)(376002)(199004)(189003)(7696005)(66476007)(186003)(4326008)(16526019)(66446008)(956004)(66556008)(53546011)(6506007)(2906002)(52116002)(66946007)(26005)(1076003)(8936002)(81166006)(81156014)(478600001)(8676002)(64756008)(9686003)(55016002)(71200400001)(54906003)(5660300002)(86362001)(6916009)(316002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3053;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VArvd1k289xw9n35Le4vKd3/LgLqBGOZSd2ZC50FYwqBSuWmDLrL+CO+a7yYPPJ+VG7pKacKSoK7LhP3z3OkaCOhJNxVrlbdPDy/mjITZaTruzVlbXUHZKGwwhJnwbyIXudhH+SUjGh7y+BUTTYdvuGHoIr64WW2Kx1KHIdTvb5bU1V+Xw0Q5PbcurbTg5v3oTe6l56zIOP8O12Q3S2MpSuKazIk5yHc35XZ+e2UwES5tqpeeBQhxLheEbCdBI0K6phBhAA79pUq6Qfx7qmifXVOfSOBgKuWY0XlGxWUQqhXIj84xreZYTXll19/zV32lLMMYHMSNlFKyY+u8rIPfXxr+CD6jx3WKeW8+JRxrZDGQLoqShVCtMW6kJ8fjTbws/auWNpQlQc7zR4mrbvTcbdEhwOzTZrFTt3uyU2WB5nn9LaSaVIqDgfnxDE0cmPm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20F1B25B9BDFAD44B45069263AE244F6@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f9af29b9-e10c-4b68-835a-08d7870390ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2019 17:22:48.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xljggWMNcyetclzThlHSmSUAxf/ZgAvsjiiljO6wz5X/K3e5KVByfPlYyq0hIZqL0NvKbCUTK8ViBe4TASpCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3053
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-22_03:2019-12-17,2019-12-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 22.12.19 13:15:00, Borislav Petkov wrote:
> On Wed, Dec 18, 2019 at 06:22:08AM +0000, Robert Richter wrote:

> > 1) Use-after-free:
> >=20
> > On 27.11.19 17:07:33, John Garry wrote:
> > > [   22.104498] BUG: KASAN: use-after-free in
> > > edac_remove_sysfs_mci_device+0x148/0x180
> >=20
> > The use-after-free is triggered in edac_remove_sysfs_mci_device(). It
> > became an issue with commit c498afaf7df8 ("EDAC: Introduce an
> > mci_for_each_dimm() iterator").
>=20
> ... which means:
>=20
> Fixes: c498afaf7df8 ("EDAC: Introduce an mci_for_each_dimm() iterator")
>=20
> ?

Wouldn't say c498afaf7df8 is broken, it is the release code itself.
This patch reveals it. But for patch logistics use the above tag.

-Robert
