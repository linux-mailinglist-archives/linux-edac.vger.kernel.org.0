Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022957BA0F
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jul 2022 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiGTPeT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jul 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiGTPeS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Jul 2022 11:34:18 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD861D4E
        for <linux-edac@vger.kernel.org>; Wed, 20 Jul 2022 08:34:17 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KEweil001441;
        Wed, 20 Jul 2022 15:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=pO2cJtaosHVkcbNG7m0ifW0xh/hm8c+XPFoW46JOB08=;
 b=ZHsRfy6xhGaeD7oCbO4vt3FEulBLc9GswItMxEIp36KdrKSZQ/DiP1S5f4834/tK7XIH
 tRxh0mCZ4Sys6etRQ7QJrTPUz24xItesPhGAoWV3yMVW/r++G4spLF20OI0fxzw5KYln
 1vB1T1J58lai4fviJ2ct0hiwSBiuxu1t2WGVt0ZpbA7M/D9HYFQ+KEsGSZ3TacTH7h3W
 WGarenE1chTzWnBYqf8d5gs+TgDHb/IgImUqkItRmJOD3BBqA50Yl2yI/mYYCZDqDrmt
 KK9H6FczbFyML1OoqjG67pbq2rVKR/zmcbjLcIbI9Ck2Szfe34nSZpDQd6oxgV9F55FG /A== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hekfpgkq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 15:33:55 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B0479D2C8;
        Wed, 20 Jul 2022 15:33:51 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Jul 2022 03:33:51 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Jul 2022 03:33:51 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Jul 2022 03:33:51 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Jul 2022 03:33:50 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpORHP6QTRFdbq1ahI3uCbp3+47vW9EClFx52li1UAVXZ9/H0fwA+BctPmv6TprpQcsQQByKN/8uukWnken1HQ0zUsfw/WpqQvlerqN4Ipf3yfrLulUr7onM6sIBN8+j1zyW39hE/ymp7gXABSBQpgWHLHGLi6kbjlzgZrZAbn5ZM+atQ1Gn8Inm5g9TpMZ1sw8rRBikC2cfZaHAiIWIIPMtf1OJvVrCMwVV/DiyWEsEmyH9fvpxOsuSBG2ivq14U8FoIkv7Jywa0dyB3Oy039/1He/jZZFXrHnaQUkMXqNxF0IhjjdzrYbR+6c6LyqjTfnKBpumYMDSdDY/cId4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO2cJtaosHVkcbNG7m0ifW0xh/hm8c+XPFoW46JOB08=;
 b=n5/kWXujGPmrC7UHnopATfcCiqFCRGNj+uTVcjyCu7xq9KwdSsfflzClBM+T9ciCzmS2z8x8zDfiPwh8vajkyAur3PkUwA5K1OINuK94Lq3FWp6ximD3gH0wde5EQ7b/pXFlNKDnWhd9PPIUU9B9xszB8IIacHgGH90xP37o32i47j8BgHuwuqhKwNMgyc1WaYTu6Df3EhzEefnwZsM4nNlXgDTub3KNKGUePn4Lqrv4p/wqgN1UE4gNqMia/Iyh56aj2tficVngK232ABwglrge3b9r+OwDrwZRLAK9CIS+c0lsRbcY+M8JVXfXOZ7rvGQJ3JI1Oj0DWVm17Bcp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MN0PR84MB3096.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 15:33:49 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f547:73ee:16b6:756e]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f547:73ee:16b6:756e%4]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 15:33:49 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "'arozansk@redhat.com'" <arozansk@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH 3/3] rasdaemon: ras-memory-failure-handler: handle
 localtime() failure correctly
Thread-Topic: [PATCH 3/3] rasdaemon: ras-memory-failure-handler: handle
 localtime() failure correctly
Thread-Index: AQHYnEavUEqJsMaqhEKPIyQVSXDs+K2HXvJA
Date:   Wed, 20 Jul 2022 15:33:49 +0000
Message-ID: <MW5PR84MB1842E4A18E672F6E13896D0CAB8E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220720143957.795358633@redhat.com>
 <20220720143957.977427150@redhat.com>
In-Reply-To: <20220720143957.977427150@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdafe755-4dc5-47a7-591a-08da6a653e32
x-ms-traffictypediagnostic: MN0PR84MB3096:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOB8w5GrhdFApgXEenN3vRKBgQ6btieL5jl7n+oa2WQWRC6b7qapLRTeDxsYIvN0aUf0Qz3vSJx88rI7ohNW0igsCYjEBwp7FZKG48TsCbEQfaXEqHaY1aIVPLcDWr0Gl8I0lpj4hXf8JzQIKjvq3POJoPHSqSByxq+ulH5CYcRUud6S7Z/4UO/f8MgM6OsD/Nprc2fvsP2SYrgDbkoNoIU3sNXH2CD9EewDgsKAX8GMnHdddbtKs4oPZCabK6H3fXgeh3KzxU58UxjDaHkKWuVl3qjKXr40X4Um7xraYwySVnu64jSAGE8lD9HKNzVCW1UuIDPBhGZ6R+xyYOr5WYBJg4Myr0O/dgoCMC26e7YcCbyelLxRuS7d2stpBeMNQj+0wzdsaJVI8/OYfrgYYGX+2ZbLVAWi9ampR+X24jP9oB6sB5GFIChKjzR6iRqmlpgppPj0iSXXrW/Bh5DUHqxWJgtCm3ufhkv85kPaxeUbn5I3KqerghMMYjmQSSNWqoMR27L4Xnc8MLkkmmqMszAu34KOGhXS0ZnNR4QrsbMThZwCTePYGkOZalA6l07abFHdAc4NeguDimt6QjHjVRKF2l5ola6AdpP380u41PgzeTCVMwunLLcR+jimsFk9olrs2brwAF2rNGxh1hDP4S/rbjcL1yiPjR3mHVIfob410YW7NCGs5VFX18Xx5Jm+cBxeabnTD15gdwXjf35Tg8GI/1YJEyIcWy7lgRyBpuNQehNkF0yb8aTTs0BBHx7q4HIypqwKAemADM9nVQPgeFgF4uwVe48FBZEEjBoMGcwW2+lywKY7HuBmnFjnzdrOAvuhzntDfXIvurMUB7wM4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(396003)(39860400002)(186003)(66446008)(66476007)(66556008)(4326008)(64756008)(52536014)(8676002)(316002)(66946007)(76116006)(122000001)(110136005)(8936002)(33656002)(38070700005)(86362001)(82960400001)(2906002)(83380400001)(478600001)(41300700001)(6506007)(53546011)(71200400001)(7696005)(26005)(5660300002)(55016003)(4744005)(38100700002)(9686003)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g3OQhFrY0LBSHHBCuaHT4Hrp3ziegnD6GjSmym/A4lh7HmdDr7d0B0aRNAVX?=
 =?us-ascii?Q?biExN4qfSwTlRObaVBCuGOrRSxR4RhdgoJjl/+6T2PfgprG5n+aZ+PpaSI4C?=
 =?us-ascii?Q?QBRq/feqbcVy8UP92sDUhDYjEwP5JSSVLLU2cXqcAqtlaP/earz+Vp5GI0w8?=
 =?us-ascii?Q?hBtRrd6g4se1QSPbU2jK4mxQQhk9+ppgfWrpxpyOGgDE1Q4e5xh7BgRhs63z?=
 =?us-ascii?Q?mnU2+xjaTJuX+Inn8xLl0e4N5Y71oE8Mi/YSkfCebVn/88hrq9FnFijgJTGF?=
 =?us-ascii?Q?WOo9wY1Wlo05l4uuSd7rQpbpFm7HpEOBzdAi4gMNn7BBcL/cj4un3hOqtxZx?=
 =?us-ascii?Q?8sUya/gjZkA6TBcRNfDFX+rEX2hP9qCtaSptJGcIeMycyF8G4ygcPvOr01Al?=
 =?us-ascii?Q?aXLWTpxieqOITw3pRIjBoPYBwtYci6N6p3hB6pw7mxGxfbzZMr0hzXsq3b5P?=
 =?us-ascii?Q?OsY8C6KcO/yfWEgTdS2CHEHHEp9f62pA7K2NxxYCE6IvPmz198eaY5m8w0rt?=
 =?us-ascii?Q?MYv0/xBRH+iNd1nhrGwrsKcCm3e3/vxCmpEimXfxR3F+Rzh3NApgnyPCGMOb?=
 =?us-ascii?Q?Hv/wTzOnCEkvMwIWG0Q/o/eksmbEI1xfgWNr5S2kgIaxQfp7rfiaihKapIf1?=
 =?us-ascii?Q?YYDYnujx+PBDV9OW9BbnUp18Y66ZiSK92J3l/W21eb0titCkk6LBB6JhLFR7?=
 =?us-ascii?Q?il+4z3biAFlPqMQzscsplxuCNIMEEzVTlyZrKHqygSWRsbuhivdF6qrpBe9V?=
 =?us-ascii?Q?sEaZzXkPFQXqRQdu87o36knMsb+cGHfrdovAqPdVrZUBn8Ok9h7N1e4mX3JC?=
 =?us-ascii?Q?jNkX+jhzOTUOax2PW1IdGqKMoY6hd7wH4eyD9Va3vhYGNcoPaedtlhch3+7O?=
 =?us-ascii?Q?SI1GQiV6iayq8tZvfo2pN/lQuBo36Mz2NrAfDVi62aXDOZWO+igQCgj0tG7b?=
 =?us-ascii?Q?p6c3fw6Gp99z6K4sCAs01zc/L22VG2njMIKKoNjuLRWAaY/naJ/uronSQfdf?=
 =?us-ascii?Q?9g3LDnQejZH5sYW6TTFuFqIg7fR2tI3E4mm0OMZ6fp0//StKf6V08AGTauT7?=
 =?us-ascii?Q?YxeNNpqIr8uTN8P5jv5VdgWTYbkDopNqH1td+riElmrcmzP7/n8INwNd9BU/?=
 =?us-ascii?Q?Da0Rrkpz14SNhRkhy1pgQclA46dPET4S9Hu9ckVCYpaueF7pxukmloEynVpD?=
 =?us-ascii?Q?HmUNg1O7lP9F1EitKK8xYU8jf4vWzcW0rpOkDfz81187sefSaq5FY9u5OEkT?=
 =?us-ascii?Q?Mj2ghIh+BiuIpdNW+KzD9qQQZb5dwjM3K12M32N0bsOeJhm6A5X5bGbJvo6b?=
 =?us-ascii?Q?0WvY+wYKt/nqgO4nsjKor8/k77ioRP7B83JSoGWYZ9miBbtwN7QHYaeoxMc+?=
 =?us-ascii?Q?uLh7yGwj+guPTZKzG6zjV+ZfhjE5mhJT/IhypRMfbsUR0Y7UDtPYpAxMk6Rm?=
 =?us-ascii?Q?pOMFxa2qC30ShRYVKEjqQxQkAWxQv6Ci2RoPrvKqnGCHU7kAHi+L//mNwkrB?=
 =?us-ascii?Q?xw3PmV/w3Wc52Pvt+O4rAsiH0HS/LpvIa6/sqT7ohxEkea2xq1UYgF4znNdm?=
 =?us-ascii?Q?1+95m9WX1aV4z6Mwrxg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fdafe755-4dc5-47a7-591a-08da6a653e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 15:33:49.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aq9tSFIgHJ1UtoJoLEje9+3G5Hnb8c2CjdQZHTNjc87PaVCbIvDcA769zkS+m7m8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3096
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 9K-hmzblVfunRccTvQ1dR5bWosa9D69K
X-Proofpoint-GUID: 9K-hmzblVfunRccTvQ1dR5bWosa9D69K
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_08,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=694 clxscore=1011 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207200063
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> -----Original Message-----
> From: arozansk@redhat.com <arozansk@redhat.com>
> Sent: Wednesday, July 20, 2022 9:40 AM
...
> Subject: [PATCH 3/3] rasdaemon: ras-memory-failure-handler: handle
> localtime() failure correctly
>=20
> We could just have an empty string but keeping the format could prevent
> issues if someone is actually parsing this.
> Found with covscan.
>=20
...
> diff --git a/ras-memory-failure-handler.c b/ras-memory-failure-handler.c
...
> @@ -148,6 +148,8 @@ int ras_memory_failure_event_handler(struct trace_seq
> *s,
>  	if (tm)
>  		strftime(ev.timestamp, sizeof(ev.timestamp),
>  			 "%Y-%m-%d %H:%M:%S %z", tm);
> +	else
> +		strncpy(ev.timestamp, "0000-00-00 00:00:00 GMT", sizeof(ev.timestamp))=
;


Per man strftime:
       %z     The +hhmm or -hhmm numeric timezone (that is, the hour and mi=
nute offset from UTC). (SU)
       %Z     The timezone name or abbreviation.

GMT does not match the lowercase %z format of +hhmm or -hhmm

Returning the UNIX epoch might be safer, too:
    1970-01-01 00:00:00 +0000

