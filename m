Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7F3108A
	for <lists+linux-edac@lfdr.de>; Fri, 31 May 2019 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEaOsO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 10:48:14 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37600 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbfEaOsO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 10:48:14 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VEdpwS016780;
        Fri, 31 May 2019 07:48:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=U+VTOLi62++/P+5+dOiLWkqPfvWpwHavVIbdAQTx3nE=;
 b=QDxzsc8+ghXWKY2+S4FkwuaWgM9/YyaG8ZXG08ryGCNjZqxo9kLt+NVNSWZ0/w8jfSXI
 v0q5TS4wzefMVPVRVqCPpeVOvOREKu4xfC0i1qYGucUUvUcefF+rvy+HwCPeFp3qcDsc
 EKa03UfuuW5/Vf/gjyKlSrX/jPeZq90dMUyIA113do6L170OmYPfPWT10RLfXXGtAFXS
 kMxfHDRbjbBtkfItFzY9RgB7WiBxIaq5R+EMbC8gfpgy7pthPuhA98qYSL+VQvkbS22D
 5BOlWka0JknLbk0L7cvoXNes1AJ6b7lCkPpyv/IGrxeXU+pENCzkPemWgRmV8W/0h87i 6g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2su5xh031c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 31 May 2019 07:48:04 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 31 May
 2019 07:48:03 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 31 May 2019 07:48:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+VTOLi62++/P+5+dOiLWkqPfvWpwHavVIbdAQTx3nE=;
 b=nmTfIHMwhaBJJseQDZExzNrQMV+4d2v/ALaajw9wz4Q3X3+orBqWkpWnRRTPP/gIvHot5IwTZSed6VQkQ87MAVoXD2+SUo+q+D5QWpw/HKeb14Y+sNLaZnBv8zFRvqPdBUrb6gcHSD+SugKvVqOTtktlOcWvrLLrr+qMAG0vvAM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2879.namprd18.prod.outlook.com (20.179.22.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Fri, 31 May 2019 14:48:00 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.024; Fri, 31 May 2019
 14:48:00 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/21] EDAC, mc, ghes: Fixes and updates to improve memory
 error reporting
Thread-Topic: [PATCH 00/21] EDAC, mc, ghes: Fixes and updates to improve
 memory error reporting
Thread-Index: AQHVF7/XDwOnfM4wekmLEuzXf39PQg==
Date:   Fri, 31 May 2019 14:48:00 +0000
Message-ID: <20190531144753.weodygruvgzgzjth@rric.localdomain>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529145452.GD2951@cz.tnic>
In-Reply-To: <20190529145452.GD2951@cz.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::16) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.11.73.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89e2300b-49e4-48b7-6186-08d6e5d6fa42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2879;
x-ms-traffictypediagnostic: MN2PR18MB2879:
x-microsoft-antispam-prvs: <MN2PR18MB2879A4AFAE05457497422411D9190@MN2PR18MB2879.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39850400004)(366004)(199004)(189003)(86362001)(3846002)(6486002)(3716004)(6116002)(102836004)(6512007)(9686003)(6436002)(8936002)(73956011)(81166006)(66946007)(8676002)(81156014)(53936002)(7736002)(6246003)(2906002)(6916009)(26005)(53546011)(6506007)(229853002)(76176011)(52116002)(186003)(386003)(66476007)(66446008)(64756008)(66556008)(476003)(446003)(11346002)(486006)(316002)(256004)(5660300002)(68736007)(305945005)(54906003)(478600001)(14454004)(99286004)(1076003)(4326008)(71190400001)(25786009)(4744005)(66066001)(71200400001)(25903002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2879;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dv+BIq6+yWbPBTpw00uaWpp0QMzRxAyXj+ITqS03r6cmLB4NhrKLdxP/O43qd/zsX8xu39TmZyOn9NxZV/sZkR9KW2EBXiRzYg9dIm98w5w8Tmx0r9+OuZEQh5/O8ZJZxo5p2c38B34Wsg4iKQhVilSDE4Vm1Tj5HSyPSAUuUQ06X9ozPqx/9KSrMPIL7oSyW4awz7p80RGWd8W91hWahQZEvbzPIeJey1XGsgA8S8DqNNAayg1CB3IQe1OGbS9gUPoIXy471/1w4PBPHpNAKYuTRaeDgjCJXF+dA/2SGQ0eFjbRf4mUBH8p5vHrErW0GCmACr2cDTS8zXsWnkN2iJHGirQ6YG1bxgXsI+/LMtM24fwPmZrXowW1tPAvLcz+3V6ecf9pIuAxCPbfksJTS8f4kYeOzYC5i5S8FDBJlWQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <683C7E7B2C71FB41ADB6FA27DECFD8BB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e2300b-49e4-48b7-6186-08d6e5d6fa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:48:00.6832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2879
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_09:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 29.05.19 16:54:52, Borislav Petkov wrote:
> On Wed, May 29, 2019 at 08:44:01AM +0000, Robert Richter wrote:
> > Patch #1: Repost of an already accepted patch sent to the ml. Adding
> > it here for completeness as I did not find it in a repository yet.
>=20
> Try mainline:
>=20
> 29a0c843973b ("EDAC/mc: Fix edac_mc_find() in case no device is found")
>=20
> :-)

Ah, right. Will rebase.

-Robert
