Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707151891A1
	for <lists+linux-edac@lfdr.de>; Tue, 17 Mar 2020 23:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQWx3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 18:53:29 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:49172 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgCQWx2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Mar 2020 18:53:28 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HMgtDi031326;
        Tue, 17 Mar 2020 22:53:12 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2yu71v88d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 22:53:12 +0000
Received: from G9W8456.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 415E2A3;
        Tue, 17 Mar 2020 22:53:11 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 17 Mar 2020 22:53:11 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.13) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 17 Mar 2020 22:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyMeLmp0i+Sq69hXqER+292PL6JyBQA9QgWkcbo8as8U72SIwmACRpcwf0Cz9uV2DMFRMGN+VoWxy6Z6ZAKULB9CiBtxL7iFpJHEAlCDrhaBiaxS34NsrmoKkcK8zHmqO/dWD+y/v1bXOgXVsKE0+S+XhoxwnTWAMHuVZZ+Zqmb10+wmFI52Dhg/QG1lKKYwaEhhO+zU5LDLOHX9Ku9HcxX7xq+a9afr/rDBGCFfVzQCQStiAA+vubDCK7YljnNg7OV6aWRv2P+SkStiRCoBksLJjn16INFx39dlZbL4QkN46C4QyjgoolOG3B0P9qmSuMhikMHW4IdFGoE5rl3pOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehlo8Idg/GaA2o0P62UW8KY4OBN0ttrFJOvfNKxsf8w=;
 b=gbLRdy32oTHyQRGquVTInmKr9+PAD9SwySHlGuLyb4QiD3KhKsAYJrgUzMamn8+SoOKFnFa8dhT4slpvvxaWCjoyM0ChxfhCyBl1EKhH/9zGj/pHHf6CqSULAowwcQV/vY1MlbsSZzgnRZaEl7LmO9dMPFTH8HFAF9vXH5/3uBrf5FYrvKkmsgDtg+en7vc3uPnPv68FBRu9blso7efxPwXfh/i0uU1RMO5vAP0CbjosE46Kzhgk/7gTefJDb5N8pEH9SojgzJb7/l7qkcYq3rjrO3FWHeTLDKHhh491bFX6P8M4rhRC9KV8wXPpbMcYMKub+MY1Nq0FYfBAlW0DZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760e::9) by DF4PR8401MB0889.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 22:53:09 +0000
Received: from DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::48e3:d86f:b5b4:8e58]) by DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::48e3:d86f:b5b4:8e58%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 22:53:09 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     John Garry <john.garry@huawei.com>,
        Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
Thread-Index: AQHV+3iLP8F6OUkyckG2KD2c2yLs0qhM/O4AgABeNJCAAArigIAAAJmg
Date:   Tue, 17 Mar 2020 22:53:09 +0000
Message-ID: <DF4PR8401MB073148816BE1012B3AE729CA82F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-12-rrichter@marvell.com>
 <20200316095149.GE26126@zn.tnic>
 <924f4c0e-1f9d-e7de-17cd-466eb3a74d90@huawei.com>
 <DF4PR8401MB073186E9C0F1514827781CC582F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
 <20200317225039.GI15609@zn.tnic>
In-Reply-To: <20200317225039.GI15609@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [75.71.233.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e5de34c-888d-48f9-b619-08d7cac5f6c7
x-ms-traffictypediagnostic: DF4PR8401MB0889:
x-microsoft-antispam-prvs: <DF4PR8401MB08892790265897A87D07B25482F60@DF4PR8401MB0889.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(26005)(33656002)(6916009)(186003)(86362001)(6506007)(5660300002)(52536014)(55016002)(4744005)(9686003)(4326008)(66556008)(66476007)(64756008)(2906002)(66446008)(76116006)(71200400001)(81156014)(8676002)(81166006)(54906003)(66946007)(7696005)(7416002)(316002)(8936002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0889;H:DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3beMz9sGH4b9AbIfub1Kz6fob7jSHyDYQ2l32uYGGqADBjp1/Wyw2aJT8sEQvsIQmAk6yYr6garMGtL0M85x/PK9/G8Fo7/9+YPVHnd/vdqDbi1yE71otHjVKnmHkN1olyF9WoPwoA6Cx9LqZYaPe43qfE0qnEk/89HouwrFakhwkeP5vOput11tJH697cdmmzgFe+uzQ5xBG2jN09pT6jvz2BFoTG15ggDtq+vylJq+pLx0XDfVtzaX3gULYsRg5DeTbCLjM6fy03uyKrRN7SHfgFL38NNxguFjMMy3RmONbZMsYd98o9uzf2UWj5HklU9MGGYNkm5m/XZliL2o99guzAc+oTvrlND37EmN13mxljUqCtZN9o6PBd6cS4LjA6ZCbVMAf/nz3N2kqvDl8DbhHV3CJbsr2+KPysKY6yC8Ajlq4orcppyJSHbkWawE
x-ms-exchange-antispam-messagedata: zUrbs/CbtkfMdXLMaRdwR8G63TCwQbvtLJPVpYH2ONEE2p4JW+o/n1lkDoI2WgD7x0dnDJWEd6NDkBBpY7sQvI5r/l4AMkEpA8eyWXYKZZBpCb7DF8NFLbz/+VHiaNdhdNrysjQfjy6oNeiZJX2JZw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5de34c-888d-48f9-b619-08d7cac5f6c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 22:53:09.2666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tdafLv8xu0RTXw+28frRh1gCT2/wnx/kcU4OzkNk5APl25WCG0P1DZYRysqw9g4WwZYJpVCrMjEseWOr+K+3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0889
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_09:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=882
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170089
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBPbiBUdWUsIE1hciAxNywgMjAyMCBhdCAxMDoxNDo0NlBNICswMDAwLCBLYW5pLCBUb3NoaSB3
cm90ZToNCj4gPiA+ID4gVGhpcyBpcyBhbGwgZmluZSBhbmQgZ29vZCBidXQgdGhhdCBjaGFuZ2Ug
YWZmZWN0cyB0aGUgb25lIHg4Ng0KPiA+ID4gPiBwbGF0Zm9ybSB3ZSBzdXBwb3J0IHNvIHRoZSB3
aG9sZSBwYXRjaHNldCBzaG91bGQgYmUgdGVzdGVkIHRoZXJlDQo+ID4gPiA+IHRvby4gQWRkaW5n
IFRvc2hpLg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgaGVhZHMtdXAuICBJIGRvIG5vdCBoYXZl
IGFuIGFjY2VzcyB0byBhIHRlc3Qgc3lzdGVtIGF0DQo+ID4gdGhlIG1vbWVudCwgYnV0IGFtIGNo
ZWNraW5nIG15IGNvbGxlYWd1ZSB0byBkbyB0aGUgdGVzdC4NCj4gDQo+IFRoeCBidXQgaG9sZCB0
aGF0IG9mZiBmb3Igbm93IC0gUm9iZXJ0IGlzIHJld29ya2luZyB0aGUgc2V0Lg0KDQpHb3QgaXQu
IFRoYW5rcywNCi1Ub3NoaQ0K
