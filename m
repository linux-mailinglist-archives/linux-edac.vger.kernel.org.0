Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8484EDF82
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiCaRTm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCaRTk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 13:19:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAFD3DA7B;
        Thu, 31 Mar 2022 10:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcbIn7ZsMmVQ+M2Jj0P4BpbtPdUESHYSK1w2fcrxJMJts/aoTFdcF6kzp4XKWYpEMzWdTWTR6WpR4JPEkOYkuBMgakFekLbqVsQeC0iw0HFyp79izi/Y178u0UoeV1331Uo7XLixnkZPCV8em3+/BWS67cMrvArVEm/aEOHu1YQPafeJA/77IL5Ia6B7HMLVfBckH2XjEybEwlwa3mYXUtOwuqOjL/X2UhtzQTJ9v49FBGGAEDwKr19wVJ+h94ZFvwECmY3S/UF70RO4KZZ0MFUHgt/hGRVL78IVvEm4NPuUzYZAVdqzCQjozSfuM2iS+ksRIWc87LgEk0ghqxzm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b2X8ItMGDfQ/u4cNlGMSO1zXXVtCfWVl/i73APQ9LI=;
 b=L9bzKJIil6SfTiytgSx/dU6RATHpZWidHBuvl7y0mnnlLJoqOuKPKghkvlCLka3CXZC6gG0Mt1FY9hws3FjKT4pSlSd7jXgry9lDPohYvh+hQQKskpWRtzwdJZ05uoQz60/YMHrBDv4UBv7/JOhNbsHj4nENFME/7NzSLT/vdQjbW6OLPj7Awat2solrJvjeo7pdgte0ko8D+NdLqNt2LWcLUHcu6ilUCcxB0TtQA4pc5eD/YhBDU2eGlTTnlfAn4UolCRyUOH3omf0UURo3ZqvcgMIOgmZeelTAnd8JVlh5nDLaaYi0Vp7A7Nu96KU0dyd3C1z0kPtAgb4GK1CGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b2X8ItMGDfQ/u4cNlGMSO1zXXVtCfWVl/i73APQ9LI=;
 b=t/7oimDybuPKfqf1JcecA+b2AQWXhsmDtPeipGwTyofQjK4pK9/eEUYc8GNP66bqBNCm509b6OafiTTr/Olvmoihnks10HywHfCcifDG6dgCkHDPxPvhAQbEXsBjyTaDbSUBf/mF72zUfZ07n29NumXIQyRxLPJewV4voCgA2pE=
Received: from SN6PR12MB4685.namprd12.prod.outlook.com (2603:10b6:805:b::20)
 by MWHPR12MB1808.namprd12.prod.outlook.com (2603:10b6:300:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 17:17:46 +0000
Received: from SN6PR12MB4685.namprd12.prod.outlook.com
 ([fe80::ed:70c5:200:cbb0]) by SN6PR12MB4685.namprd12.prod.outlook.com
 ([fe80::ed:70c5:200:cbb0%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 17:17:46 +0000
From:   "Day, Michael" <Michael.Day@amd.com>
To:     "Bilbao, Carlos" <Carlos.Bilbao@amd.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "bilbao@vt.edu" <bilbao@vt.edu>
Subject: RE: [PATCH v2 2/2] x86/mce: Add messages to describe panic machine
 errors on AMD's MCEs grading
Thread-Topic: [PATCH v2 2/2] x86/mce: Add messages to describe panic machine
 errors on AMD's MCEs grading
Thread-Index: AQHYRR3j44TaXVxQiUqpHxQyQ+9VIazZukvQ
Date:   Thu, 31 Mar 2022 17:17:45 +0000
Message-ID: <SN6PR12MB46850731F74982FFAE6433BFE8E19@SN6PR12MB4685.namprd12.prod.outlook.com>
References: <20220331163849.6850-1-carlos.bilbao@amd.com>
 <20220331163849.6850-3-carlos.bilbao@amd.com>
In-Reply-To: <20220331163849.6850-3-carlos.bilbao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-31T17:17:44Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=514d57da-c90d-4343-a816-cbc87bb029d2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-31T17:17:44Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 1d4edc54-daa8-4ea1-9765-c1aebc9d08dd
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e099812-6e11-4aef-a6a6-08da133a5fb3
x-ms-traffictypediagnostic: MWHPR12MB1808:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1808F6E41ADD9E0910A1699FE8E19@MWHPR12MB1808.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cb+GzsIgy/ImS0NwHuqOdDSKJCbjgOvGepF9s78d1Y1XyBqinGjCK3WjWK88/nIdJ/qWU3+XU+bbP2kBaAOM8MG/GXizcqtFRkBcSOnAtSp9MNA0u2Ey5AEKbTpoBg+d979FtX4rtcoGIXHB123Pio45JxPd6l6X/8BMFGZgBdmxzAlahG3CRkcqLJE9q72R16Ph7Nb+8xOCYvYbaWzXw9/2bZiitHgWX95e5VArR2c3NNuyDLEr2dL/S+8vKcUeTtxRIsIBn3J55OIy5xU8+zo0M8bvC+qd3RVTdUe24pQPCi8G+cm1g2L7UF4fBf3fYWg+SLliWFtTBRjNOqG8pv923JCTisGGeGt2mLEUYX2pZByX+MDQa9nA7VZ5a+ko3+DFzRYNmfUqY5GjlYj+Plyx+iT/YCRfPSB91uaGrO74HTYQz5D5SO4bLhYDP5uMpfaVjmuk6p9EMsGVKMUzcYNeoqgpiCyKnCEJQOa0dIFaXwlBtYelJjatzpopLjgpLWoH8DgZ/YaUJwjHxJ64D8Ux2Wt4dPPHlvWL7Ir2/Ycg98kQZmAE1fp9aIZaOk4kQ0TIDLPF0S24BcAZ8sAGUOrOY/VXrUqAINXe1tp0m5nWMR/88YITLfoDnCtAfoA3yOrjlFARVyneMW925UqRVF5rURIQTHoXxgo1muRyRidz4GrUw98cQ63UJxxI5HXPWbdEMpf+kZRwOEpivi+7YQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(38070700005)(86362001)(33656002)(122000001)(15650500001)(52536014)(316002)(2906002)(5660300002)(54906003)(9686003)(7696005)(71200400001)(64756008)(53546011)(110136005)(55016003)(508600001)(6506007)(4326008)(66946007)(66446008)(8676002)(66476007)(186003)(26005)(83380400001)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ARyCyf2b+Y7fWg0jj5Zlv/5byciOG4E+x8wPdi3CvPvU223YpPAjBlBO0Z6s?=
 =?us-ascii?Q?jXkLLUPTDmlCA5qoDCFLlHr+71jGfT2eZXFdzEyxyVxImd6vY/FpMRDW/9TM?=
 =?us-ascii?Q?gwWQ6CPRnWHZl55FcYF8lnu8AQlzdNAvNNAiUq1sFkOvaAt+LJPM1KfVwqH/?=
 =?us-ascii?Q?Ov2Hh18dftJx0zTYzFBl+sZ1H7ywD8cnw/fZQ7kzH6+2/dYHZ24Ov//RVKIZ?=
 =?us-ascii?Q?IDtrMeUJrCJ9PwGJGXHuEcw8UseEHMyAu0I6Bq6IsmfIX3DhCKrmcS0mYNqX?=
 =?us-ascii?Q?WHIjTkNNUh6BpQ9+QjjPWnSyjQcCk6+p2riasmilEsCk5Nt/WfMZSR4QbHbJ?=
 =?us-ascii?Q?bmm05Cw1nGYMC6gR37GPcn5fl9VLzo1ydG4LmGWtdDSyICQcDlMks2HcliPG?=
 =?us-ascii?Q?mnHalU3kHn0giOh5ZIA6MCl466mH2OHZ+SJAlkKOf3kHCyhyHS4Q5cIHRIKj?=
 =?us-ascii?Q?tgwa/IKYPACOafInuZkp0OoPW+6OwNywwXJz2u1YpKEvm3qq4htmgUzKCImv?=
 =?us-ascii?Q?VDU8KVt011v3t/1rvpCYx48/G61Wy2MMEduRvAFVJQMaHUL86a5L+T8/Ibu/?=
 =?us-ascii?Q?X5+4zC9DD8yUbhIiEIHWzrgMm6wjaCV/dcjWPGjPmG0Jbq1vdwO/HUC6YOgS?=
 =?us-ascii?Q?ctD0hNkxFJetqVg3eQgD9YS+BaBtxJFGQmSzjfPDWmkIhePEN+SjGnh3KeEF?=
 =?us-ascii?Q?wVuKSumFQVHaQMZ2yT5aH7GsnehHTJxTFlY1tWhuZ+8SiUDdsqM/UNJGcDbp?=
 =?us-ascii?Q?6yrITLYecQ/dmNhO2BHDLsFfMl+S0nkIEbEBhOh6DxK8pVA6B7+Qj1r+TzWl?=
 =?us-ascii?Q?6uhjc3eMSaAR85AqSUYREI/EEwG0LRpg2YtZkiCZUySF4JWkddY9737M18sV?=
 =?us-ascii?Q?72zyczD5wjMwGlpjI8ETHrUc3UDM7mOM3hjDBo38ezPfxp058Nr9EaEbu3md?=
 =?us-ascii?Q?APt6AW+I9YgM4t1L6rrrvGp7HvHlKnh/zsvmphQidRBbMK16c8WEroCz5dbX?=
 =?us-ascii?Q?OkeDl5PkGgtCxjvso/l+QaezY3VdVkslF3cBQBS9Ht7p0JA5ypgS52KuwO+6?=
 =?us-ascii?Q?phkm8TPvTq+KddVOUqsqCET9bFrp2I1xW7IAx6DCjFTCU2uCSLNyGsMdn6dw?=
 =?us-ascii?Q?10upTdKuUN0nsdT59wmn+tzhpStj99yPIfEobJbBbWgrcmbRbmivoxITHTWt?=
 =?us-ascii?Q?K6u9gjAyraNCUOxnTQjGfARonzfhW3uoS2OxMosCN5VZaS/rVz8BBj22/Y7l?=
 =?us-ascii?Q?IRposrMpTwOxiY0UbA1ZvfL0gDKJ803TShGCMwgX/NLgdelgWp5tulWJCDnB?=
 =?us-ascii?Q?lxHcc7AQIbEq8wc3uM1nLjKNGQCBXxjgy1z6J9vJY7UjQ4mwjUl4CTdKkZl+?=
 =?us-ascii?Q?0Ajzqp4x/VG54paLe2tGHJhR6dNaJ5YwRpJDYukg/zL99XprsUf66dL9Q6mf?=
 =?us-ascii?Q?/F/9qFZRq6aHJGQxZIzpfLH2EeUi+ysGkK4zRLXEmi8UqNnrHMP6cPOeCsVm?=
 =?us-ascii?Q?dlmyMGedpFxplHaIt8/wn+25RFPxwVJd5bO7nFZlnwilgcpZQcMAlIxJ/5UZ?=
 =?us-ascii?Q?Af9OxXuRO1uY60UV+AxvjB1CKr2cYQBFaIDbBCbulhVLzg8mYhuBCvhp5qMa?=
 =?us-ascii?Q?xksTqqH/F8pqux9RNP1hbHxNbytuQ1/PBSJyxLwkcUgDy8yK7Ax4hWM+M5er?=
 =?us-ascii?Q?2qucEF1KMrKUV2Af8b5KOiyndSv8AIlaTuoHt7QHA+eUsOD9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e099812-6e11-4aef-a6a6-08da133a5fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 17:17:46.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4h2g+PWuxxwwPf+0LYkzEY4+qLz8ZExjnF4W6rDazjF0v+a4x1uaxfuCuwnHO5yWj2rZrsEhk5qqEGTtpmVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1808
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only]

-----Original Message-----
From: Bilbao, Carlos <Carlos.Bilbao@amd.com>=20
Sent: Thursday, March 31, 2022 12:39 PM
To: bp@alien8.de
Cc: tglx@linutronix.de; mingo@redhat.com; dave.hansen@linux.intel.com; x86@=
kernel.org; Ghannam, Yazen <Yazen.Ghannam@amd.com>; linux-kernel@vger.kerne=
l.org; linux-edac@vger.kernel.org; bilbao@vt.edu; Bilbao, Carlos <Carlos.Bi=
lbao@amd.com>
Subject: [PATCH v2 2/2] x86/mce: Add messages to describe panic machine err=
ors on AMD's MCEs grading

When a machine error is graded as PANIC by AMD grading logic, the MCE handl=
er calls mce_panic(). The notification chain does not come into effect so t=
he AMD EDAC driver does not decode the errors. In these cases, the messages=
 displayed to the user are more cryptic and miss information that might be =
relevant, like the context in which the error took place.

Fix the above issue including messages on AMD's grading logic for machine e=
rrors graded as PANIC.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/s=
everity.c
index 4d52eef21230..ea4b9407bbad 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -307,6 +307,7 @@ static noinstr int error_context(struct mce *m, struct =
pt_regs *regs)  static noinstr int mce_severity_amd(struct mce *m, struct p=
t_regs *regs, char **msg, bool is_excp)  {
 	int ret;
+	char *panic_msg;

I suggest char *panic_msg =3D NULL;

Simply because its stack-based and a non-null value may get assigned to *ms=
g after the amd_severity: label.=20
=20
 	/*
 	 * Default return value: Action required, the error must be handled @@ -3=
16,6 +317,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt=
_regs *regs, char **
=20
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC) {
+		panic_msg =3D "Processor Context Corrupt";
 		ret =3D MCE_PANIC_SEVERITY;
 		goto amd_severity;
 	}
@@ -339,16 +341,21 @@ static noinstr int mce_severity_amd(struct mce *m, st=
ruct pt_regs *regs, char **
=20
 	if (((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov)
 	     || !mce_flags.succor) {
+		panic_msg =3D "Uncorrected unrecoverable error";
 		ret =3D MCE_PANIC_SEVERITY;
 		goto amd_severity;
 	}
=20
 	if (error_context(m, regs) =3D=3D IN_KERNEL) {
+		panic_msg =3D "Uncorrected error in kernel context";
 		ret =3D MCE_PANIC_SEVERITY;
 	}
=20
 amd_severity:
=20
+	if (msg && panic_msg)
+		*msg =3D panic_msg;
+
 	return ret;
 }
=20
--
2.31.1
