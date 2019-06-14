Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD848457C1
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 10:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFNIjT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 04:39:19 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54914 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbfFNIjS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 04:39:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5E8ZBd8020363;
        Fri, 14 Jun 2019 01:39:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NnMeY/Ld1lXj08MXK+O/vTdP+YlNrzQcjbKy25KuYgM=;
 b=pCtHav5b5OEWyQ3ozVAgac2i9HB1lby9jxeindS0amGtLr5PJA4UDrK+3XVzsRN+xGZX
 CR9US5hn2xmHaECVmQkE/6EaZXY7/kYhhDiyln6/qge6O09VmTHGBVMQOA92wduMIE0C
 ibBZK/nSsuP4oueuw2vpAnKxU90KroUzm+DfvZfMhP+DsaX0uTQBfKQn1Pw3aLi9QtHv
 A2X3r3VP+5FLhnvMvPSh6DX5f4/1gwn7Yt2MI0UWpsKAItScZE/F9oP0M0HTkta98y1a
 KH0viFrulMGm4gAP+sMmoPIBzl5kYACBDaIxgwfLbdYG9gbVWbeZCmLc5YtPvKToytk/ WA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2t41j61f9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 01:39:06 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 14 Jun
 2019 01:39:06 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 14 Jun 2019 01:39:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnMeY/Ld1lXj08MXK+O/vTdP+YlNrzQcjbKy25KuYgM=;
 b=jMyfr/rX+gKIpUnYwp8PZPllsVU53lPEWV88HgabvBLD9oyheFrve6yCispsZKfedr3c5jB7oUpbDWmsEa6bL7q7mH7LW6TXhOxXeLzwxUiLQmVwEAfiTVKql/9rWecQ211SYM9tSmpRgdxU+vg3pcQaLXSSFEeZkVVzDHOGvos=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2815.namprd18.prod.outlook.com (20.179.21.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 14 Jun 2019 08:39:01 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.1965.017; Fri, 14 Jun 2019
 08:39:01 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVIoHTCQs47YBdYEyrNX78UqEud6aa1C2A
Date:   Fri, 14 Jun 2019 08:39:01 +0000
Message-ID: <20190614083853.zsh7jycfnp5dnj2l@rric.localdomain>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
 <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
 <20190613224130.GI11598@zn.tnic>
 <20190614072139.vzet6t5erl6uz6st@rric.localdomain>
In-Reply-To: <20190614072139.vzet6t5erl6uz6st@rric.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:7:67::11) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab5f8072-a74b-4275-59d1-08d6f0a3c00a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2815;
x-ms-traffictypediagnostic: MN2PR18MB2815:
x-microsoft-antispam-prvs: <MN2PR18MB28157E1327332CDA57CF23C7D9EE0@MN2PR18MB2815.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:210;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(305945005)(5660300002)(52116002)(7736002)(54906003)(76176011)(6506007)(25786009)(53546011)(4326008)(66066001)(2906002)(316002)(6246003)(229853002)(1076003)(99286004)(6512007)(9686003)(53936002)(6486002)(6436002)(14454004)(71190400001)(386003)(71200400001)(6116002)(81166006)(66946007)(73956011)(446003)(478600001)(11346002)(64756008)(66446008)(81156014)(66476007)(6916009)(26005)(3846002)(476003)(8936002)(186003)(256004)(102836004)(8676002)(68736007)(486006)(66556008)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2815;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AfWTGJRUq+wVAmi4qLP2rTzO9dt5rFsCcwP5D9Ighnk/ehcH6yspUjmWvZ+yFvr9JWhqFiIcJVOtTzN6rOemj88ejihUdSS4NMlWgDfTEW/LqPVfBUQAACTA5+v4JkTQPbLG1dnJrRn4G140v85nnOBNoYnJLSPEisB3/lcE2eUyf5pPJ24Ije94yGqrLzHl33ZLrAZ563xT4JJ4vXSjhFg4HhyKBbP8Es6EFPMDADZEMW04sU27Hde4NCrV9vTnDJHTI/KQodA9a8F24EuFXYO0GzC2OlN4ovtRnHRBGvu11eyu0lyVjIvRll4Tb5COou8gdRU1vtdXsNmj1AbAuT1Ahv/EP510+X6w9kP01EvWFbW5AzfAPeKpm4YcmffQYzZXIKDpyiVcaWQr4ajAQveZtXgy8mYcJZJ4EOX7ZhE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CDE1775C8962246977C1EDA426848FC@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5f8072-a74b-4275-59d1-08d6f0a3c00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 08:39:01.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2815
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_04:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 14.06.19 09:21:39, Robert Richter wrote:
> Correct for edac_mc is:
>=20
>  grain_bits =3D fls_long(e->grain ? e->grain - 1 : 0);

I have this fix in mind + patch 11/21 (unify trace_mc_event() code) on
top which merges ghes_edac and edac_mc:

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 64922c8fa7e3..0f8d983dd35f 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1236,7 +1236,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_=
type type,
 		*(p - 1) =3D '\0';
=20
 	/* Report the error via the trace interface */
-	grain_bits =3D fls_long(e->grain) + 1;
+	grain_bits =3D fls_long(e->grain ? e->grain - 1 : 0);
=20
 	if (IS_ENABLED(CONFIG_RAS))
 		trace_mc_event(type, e->msg, e->label, e->error_count,
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7f19f1c672c3..ee65ff43ab6a 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -317,7 +317,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
=20
 	/* Error grain */
 	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		e->grain =3D ~(mem_err->physical_addr_mask & ~PAGE_MASK);
+		e->grain =3D ~mem_err->physical_addr_mask + 1;
=20
 	/* Memory error location, mapped on e->location */
 	p =3D e->location;
@@ -434,7 +434,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_se=
c_mem_err *mem_err)
 		*(p - 1) =3D '\0';
=20
 	/* Generate the trace event */
-	grain_bits =3D fls_long(e->grain);
+	grain_bits =3D fls_long(e->grain ? e->grain - 1 : 0);
 	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
 		 "APEI location: %s %s", e->location, e->other_detail);
 	trace_mc_event(type, e->msg, e->label, e->error_count,


-Robert
