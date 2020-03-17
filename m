Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29CA189127
	for <lists+linux-edac@lfdr.de>; Tue, 17 Mar 2020 23:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQWPQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 18:15:16 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:23582 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgCQWPQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Mar 2020 18:15:16 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HMDfaE024251;
        Tue, 17 Mar 2020 22:14:50 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2yu3pbhr97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 22:14:49 +0000
Received: from G4W10204.americas.hpqcorp.net (g4w10204.houston.hpecorp.net [16.207.82.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 6FDBF77;
        Tue, 17 Mar 2020 22:14:48 +0000 (UTC)
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 17 Mar 2020 22:14:48 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 17 Mar 2020 22:14:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMPiNnDPyLRnPdghKDhiQKct8q0n3um8chvq7IDjSeivmK4B3WCWqEmJ8mUvUDGYm5/Gsxkjj3O7sCeBod0Zg65I4+kveXa3OPbn+NttDfSufiHvodggKl8SzrX9dQqHpD4t+7AN0XtbJGAOHteHAbb1U+1r+BT796udM15KGt6Xe1khV+M3COx+9oeh+zrdGKrls6HOSM3WWT/RKzUT2/fTMy68xN838EyNM+tYybT/p8dLoRlxQaz3uUwGL0x6eu/8AmI5Kmc6uXsc1rRVu5xsUmievogBpw0I1Srg/Lwxs1T/sRULfqzM1nmJM/f6ZgLEnbKFUcMq7ksqVFsOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgNa5HRyH4oBzKDawgkmp7LhIZjxOijbiUn5pu8YUw4=;
 b=BE1TAZAiniK7d3Bpoz7MolsN05tVFpkha7AOCxvxWwbCjoxwtTV5Tez5SYZQccMp8k7a37bYnu2tuv/zj0ezUZ/ZxAFG1M7vbp1+DHYKx0Ii9i1Q3+y5N5cn1xQ7WI/NejdYBuywmQsm5KfLcne4HYqvrQAo+aWQK2EK9m+7fNV+gg+7ykWBBdaftzfqh1vkoPHNGUw0TrdKQwLzvGIg28rDz6GlSzSUa+AcNjbQjHoYvi5rxmWaU58e5SHdcLhxEMgLGHjspzU6B9Qgo4TZK+bh4d2ZI97P3g0rI1asuYFbxHnmZ1ItaANeaL5WNHvqN/TatXkjP7v3WAUcCA766g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760e::9) by DF4PR8401MB1147.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 22:14:46 +0000
Received: from DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::48e3:d86f:b5b4:8e58]) by DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::48e3:d86f:b5b4:8e58%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 22:14:46 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     John Garry <john.garry@huawei.com>, Borislav Petkov <bp@alien8.de>,
        "Robert Richter" <rrichter@marvell.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: RE: [PATCH 11/11] EDAC/ghes: Create one memory controller per
 physical memory array
Thread-Topic: [PATCH 11/11] EDAC/ghes: Create one memory controller per
 physical memory array
Thread-Index: AQHV+3iLP8F6OUkyckG2KD2c2yLs0qhM/O4AgABeNJA=
Date:   Tue, 17 Mar 2020 22:14:46 +0000
Message-ID: <DF4PR8401MB073186E9C0F1514827781CC582F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-12-rrichter@marvell.com>
 <20200316095149.GE26126@zn.tnic>
 <924f4c0e-1f9d-e7de-17cd-466eb3a74d90@huawei.com>
In-Reply-To: <924f4c0e-1f9d-e7de-17cd-466eb3a74d90@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f0fecb9-f978-4ad1-eeb8-08d7cac09a13
x-ms-traffictypediagnostic: DF4PR8401MB1147:
x-microsoft-antispam-prvs: <DF4PR8401MB114787F37BA7BAD162E4E37282F60@DF4PR8401MB1147.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(71200400001)(33656002)(76116006)(2906002)(26005)(66476007)(52536014)(66446008)(4326008)(66556008)(64756008)(558084003)(66946007)(186003)(110136005)(7696005)(9686003)(5660300002)(7416002)(55016002)(478600001)(54906003)(8936002)(8676002)(316002)(86362001)(81166006)(81156014)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB1147;H:DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OC5xMY2FaO6ty17YNIxFbx4uMoq48sSnaT6B1y2uCShL9pDot0je0nGKfBeFMYoMvp4jcYWn/KwmRYx7IIQMzXOipAW35kpPQ6RnVSKR8QjjC67gvvTIBLyxmKq2E03zW4bkj376PwpquWrE6nBJEqFil5909YxJezYm89z3J5tDv8X2Kn07oZh7mq5NpDFTCK0e+Gr8ydH3N8CFgVr38dpbOQ+8rp5gkRtXZGZy5d6elgM2RIGTBFh3XILdtBvkElSjGbi1tSMT5aRGYHxxDF2wK8DOa2xz8bguA79/f+08xAiZSuhRhxjnCvxTR49/greMAiP+khzPGiAM2TxA7zhX+5b6c7GzuQ5GVkInOo1sUqKL0C4S0IPBMWLscf52GfFBUwYfhMC0/VdCibAFKVpreqUYYYbJW7Gu0Z2gObDjd0sXcCZ0yT7IBJaroA6P
x-ms-exchange-antispam-messagedata: q59/lMHjCHFh++AEwWHZwInovJ8mQYjZTv4L1LGe4CJ1nFPcYaLCScs7Ww2746gNeYlSs8jwfrx9I4YnN/aDfFOxx6N4JYl9S7B2bDsbrJATU6ULpoe4N0MaIiCPrlE8VwGkg2Vz/DL3v7YESvc3vQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0fecb9-f978-4ad1-eeb8-08d7cac09a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 22:14:46.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmNP49f7eqhOXPQVZYLuTJFz9IaF5hrLrhAEZcPjNMQQYMaHFdKu61Qq4b/ExJiYM1pojbpKoV1EyKIhi/i9wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1147
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_09:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=853 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170086
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiA+IFRoaXMgaXMgYWxsIGZpbmUgYW5kIGdvb2QgYnV0IHRoYXQgY2hhbmdlIGFmZmVjdHMgdGhl
IG9uZSB4ODYgcGxhdGZvcm0NCj4gPiB3ZSBzdXBwb3J0IHNvIHRoZSB3aG9sZSBwYXRjaHNldCBz
aG91bGQgYmUgdGVzdGVkIHRoZXJlIHRvby4gQWRkaW5nDQo+ID4gVG9zaGkuDQoNClRoYW5rcyBm
b3IgdGhlIGhlYWRzLXVwLiAgSSBkbyBub3QgaGF2ZSBhbiBhY2Nlc3MgdG8gYSB0ZXN0IHN5c3Rl
bSBhdA0KdGhlIG1vbWVudCwgYnV0IGFtIGNoZWNraW5nIG15IGNvbGxlYWd1ZSB0byBkbyB0aGUg
dGVzdC4NCg0KLVRvc2hpDQoNCg0K
