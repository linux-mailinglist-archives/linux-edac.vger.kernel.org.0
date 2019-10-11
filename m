Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA0D3E90
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 13:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfJKLgb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 07:36:31 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40548 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727226AbfJKLga (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Oct 2019 07:36:30 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BBU1fI018939;
        Fri, 11 Oct 2019 04:36:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=/7WaXvM10v3YP+xsBuVRFyMDKsoHjVR6YoZDBj+dVpw=;
 b=bn0gn7G/Ug1Gpt9f89J264bKDtAN7tLGmXNHfPe2LKP+Tsaj+B+1kFB+giHzIn4CLo0B
 JYlae2gR6aBSfQVvU+0az9gXW7tNuXsq6p8mFIzjsZdPMpHbcT3hZYMDXhqwdueOINRI
 Ep+txStvpISjGqk6kNWQQPPr3/es6Eaug70NSRqcnPGs5W2YuWEud5AaxE9YOG/O5Z/U
 FA82AI5sRnS2Ht/fzyqlHQTPOrOnNChKjsnFgeVfsy/Y5jymSDTXWXkkRxMNni7KDRJB
 Vc4kS0C+T00uhrdHGIJ/HoRgiW+mdC9lctLA9fSzzd30TH1QyDh50gboG8DPguQSSdRz og== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vjj6v1dwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 04:36:16 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 11 Oct
 2019 04:36:15 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Oct 2019 04:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUKVhiQLhQJrgAycBJjpeDMeHYOuz5ydHHSV5qOqvdHx+6U9PAKgNtCKFTjVTL7fTiQO71kirFdl7zlNGRIbNNXPGuaU2A5+iHa2mlcsoqdEWAWWr/KrNY2yGzRgutGyVO4fjjuOGzZ1IfhY03eD1RCCtCfieKQP4Z1pdIqQBf/lZ4Awdvdo1oFSO8VZFcMHqel4ldld2UozuleA7cuuacFCrpJQfgAco78f76CfVIU0C6TzfymzJa6Kn1/MoAKSusNU8phv8Woz0yyAOTDKsKNIylD0jKu9b48T602knbImnzNZJelk/xNVx6ih15wAA2A4P62OpajnacYzNHZMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7WaXvM10v3YP+xsBuVRFyMDKsoHjVR6YoZDBj+dVpw=;
 b=NsfhkI5aaYGpP/RlrAGo5B66K24QnUhibxUdICbTg5ri19nLumoNp1v8U+gr1B7nzvamEpO+J8MGPNt76z8O8GSAnT98K+CrioUetbsVkYMkKfpPDffHFr9MiEVjeq4HGMy0JAA5EVr/Jgkjhn2Oq6R1jeb1sL1WKQNCAhkho4xoEJ/cN9dNtaPrg3O4pg+SPZ5mYS6ZLquIZLLG3fV3RIr7PDvLlIWGkfbBF0YoQNs+hePUsQx4dEDDtzQ5DTHSXAvjXQjQ1UFshz39AvfRPtgMhqtarvGOQPvjOWRjRPBqoBH/xFyCA2SiT+IuQllRUs2OVKFOrjiO7qIHX5QGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7WaXvM10v3YP+xsBuVRFyMDKsoHjVR6YoZDBj+dVpw=;
 b=c0xeLvT0M1ZHT6f8gP1Qs3W//ALRSYeoyWScu3aOXeAOoQyBqYwW3s4kYbo1Iko2a1UNvX8ArA72o72efSvKjR/bkeDMzxukAvdZ3n0SY9wOENNRtkyY3hncdRntP99K86u8QcYtZkCvVGUE1N2zERRj6rietmUCfhLTTyNfFZE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB3088.namprd18.prod.outlook.com (20.179.21.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Fri, 11 Oct 2019 11:36:13 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 11:36:13 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/19] EDAC: Remove EDAC_DIMM_OFF() macro
Thread-Topic: [PATCH 02/19] EDAC: Remove EDAC_DIMM_OFF() macro
Thread-Index: AQHVf6jOVfuHIna6UUqSRNg3t3vfNadVOH+AgAAYUYA=
Date:   Fri, 11 Oct 2019 11:36:13 +0000
Message-ID: <20191011113605.kthxq5g27qqsbsu4@rric.localdomain>
References: <20191010202418.25098-1-rrichter@marvell.com>
 <20191010202418.25098-3-rrichter@marvell.com>
 <20191011070903.546d865f@coco.lan>
In-Reply-To: <20191011070903.546d865f@coco.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0048.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::34) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17936e3f-3ba0-48c6-5f11-08d74e3f3823
x-ms-traffictypediagnostic: MN2PR18MB3088:
x-microsoft-antispam-prvs: <MN2PR18MB3088EAE912833E8D04F9EC51D9970@MN2PR18MB3088.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(446003)(4744005)(386003)(71190400001)(26005)(81166006)(53546011)(186003)(5660300002)(52116002)(6916009)(81156014)(11346002)(478600001)(8676002)(6506007)(256004)(476003)(71200400001)(6246003)(1076003)(14454004)(25786009)(66476007)(486006)(64756008)(66556008)(66446008)(66946007)(102836004)(86362001)(76176011)(305945005)(6512007)(7736002)(9686003)(66066001)(229853002)(54906003)(4326008)(6436002)(3846002)(6116002)(99286004)(8936002)(2906002)(6486002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3088;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7ErKwgD6l6Xbw+GJsUNzYbntwXqLGwQBXtYUm3qFOFFgk2rdE5xYEUuqYfcCA/2KnhyAXkvx+6d+43SpC19sKxkGtzDSdsOLZereuLyICmvenE5sCvU9ByDU9PazVM1leEf6l7wiTaqICzt6FA1Cyy8YslpEQ46CJbIjEx/q/a2f9KozxsGJOi8ULoCRBmWAhRyJKBZm8JlrSk0P1rAqEbTtAcNKgCk7L4P7o+s1fnt/VNFw1pN38utTJm/bAU/L/+a0H3839qdcPfWAtMAqclaj2Xg/sX1Jz5Efqcoizc71bMDmizKfd5VCU0/jrVM3GgYb8JIJD5g0YGzZgYAfvh+8dCzz49uaMuL6zJEDQy7/CE5ampUbdamifds4KnplOOKX6oIOFykcs/rp30PC0DjPKxVa98Lxk8kyBxsIC4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6157D1F5F17F504CB525708C8D3DA382@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 17936e3f-3ba0-48c6-5f11-08d74e3f3823
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 11:36:13.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eH+QJcH5X+IHBLr/b3TwPA6MYj6Gg2v97DqtlAsRjlWu3UGmPg8j+vlmeZkUrhoB6RevuFhrp27rsNhAvBaeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3088
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_07:2019-10-10,2019-10-11 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thanks for review.

On 11.10.19 07:09:03, Mauro Carvalho Chehab wrote:
> Em Thu, 10 Oct 2019 20:25:07 +0000
> Robert Richter <rrichter@marvell.com> escreveu:
>=20
> > The EDAC_DIMM_OFF() macro takes 5 arguments to get the DIMM's index.
> > This can be much simplified now as the offset is already stored in
> > struct dimm_info. Use it directly and completely remove the
> > EDAC_DIMM_OFF() macro.
>=20
> Ah, now I understand why you added the dimm idx field. One more reason
> why to split it on a separate patch (or perhaps merge it here).

Right, it needs to be part of the this patch.

-Robert
