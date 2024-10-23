Return-Path: <linux-edac+bounces-2194-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3579ABE6B
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 08:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20EB1F2171D
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAD71448E0;
	Wed, 23 Oct 2024 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="dg0KnjzF"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA29EAC5;
	Wed, 23 Oct 2024 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663760; cv=fail; b=Vjh+e2fdg1ObdxTyutjuzztga2ZB67PLXXhc4mMoRZPiX5EJ3CLFH44xXgExGNheqT65rrwDnJdJvGrazuo7PDsYGVUWLg+2BGYqn4ew2ClYbCjiGlwioJJMOaMmCumB1pnCUqLENIUmvar0J5wvWuQ8tYaUgRZSaCVqaTlUgD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663760; c=relaxed/simple;
	bh=k2YjXeNZeZHQc33ai29bCj/UfmVecb/TOcZs7LGKzOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4+wqlzFRVNf6a/jnAgfqvC/ihfcxjUo3K7kEywwdA+gODsmeA9+oaPt8Ntco84PyEP6lHS6ziOFUlwWypvNtIR1q2+0oYz9CAgwG4tNTTh6kJzHff/OB0jEq/ZMRMK+YNZJrTbx1ZuVobVFSUaoUsgcoUv/ZzlROYynqcEGRF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=dg0KnjzF; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0qyEzPrteSKwfBHIW9W1AazGsFKXn1T6MxKkd8I6bz/Et4Uz75ni2Gkeok73HVWGHxeSruJlSauW/27YWuW8vt0f/n6iJTj9nJWz5RWrbBlpEui2QKJ0gcvm56XY79X1V8RbjqGHjyCW1StodPjmnMM+7X9weeIdD3nTLxntKloWkWkRrGQ8SHiuQyjSOil1DG1zoHxhbal+zHOK4aEaBs/XYKvqKZyMZbCMNa8kveakKfsr6tQM+0vJhh4XUj0GS5y3n6TOVON93fWasYwEe5mjyyG0jkKhnnNGokliaAf8o/NVqqelIfLoaIFNCjbzmcVT1V2xTyM9vTEOhtX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yucA+I5UDpzEQyxLEK5MQBNtobH/pSGX3UqvAavfPLs=;
 b=r0Jk/Bm064bJQsb5Uec55zKP3SbeWfRV86GIj+OlyExVTWpQPfQLRy9kAKSZj7tnzhhTEdtjKY6uxKGhbufZ8/1E6CDqv9m0of4aOqn5Rt/SR+OGT7l19gewo9CNprjZcyY51z7pdiW7lggKDToRPWjP/n+O0Tdq4Jh3feyoV6sr0Y2F0DDN16NVSkACNClEdgyoEKBeqoP/uQPsMG5QLIrizWDEbiimcC7VgAvz9ag7ZTHbvvSe/U1w1qPVc4XeVDcDKGg3ADjkzQx8lfLYWHILdspVy0iY2X31F/c85yYVaXwKE79Sku6cCT5NrdbsHYhelSFkREPDPeOPGWo3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yucA+I5UDpzEQyxLEK5MQBNtobH/pSGX3UqvAavfPLs=;
 b=dg0KnjzFj8AXcoA6GDUIUcaEHttTRUPupDLpHxhmKZ4qVh1eVdJo7CeWGUpN+ZG1cIy5zCr9pt/wEnRT3f7OmuLGwV08+ZLG+Boz6Y+EP2Y/3/is9602jBOqrK7hOg2Fg5Dqio/RxlB3dPFWaeK23qwt4BPi8tw0kYh9wzSGIky0mO2ZHY8oFvUkPXVhtd1B6bLN3x4R37KU7RnnpMh6EXcFQH34E/2Qpr9NLMKe9LFGaK5E3b0FGcVo7yaSLfpnckxFeXJHxDNDYSc0MDsP5ZVV+aCcSc8ZfHC6qvAWbKtWbZctH8NHjlQB795tCCrNaDyMCbyBzKLDVxw6KleVqw==
Received: from MW4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:303:16d::35)
 by BN0PR08MB6901.namprd08.prod.outlook.com (2603:10b6:408:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 06:09:13 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::fc) by MW4PR02CA0012.outlook.office365.com
 (2603:10b6:303:16d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 06:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 06:09:12 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Oct
 2024 00:09:09 -0600
Received: from BOW36EX19A.micron.com ([::1]) by BOW36EX19A.micron.com
 ([fe80::c9df:f193:15b4:e222%8]) with mapi id 15.02.1544.011; Wed, 23 Oct 2024
 00:09:09 -0600
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: Shiju Jose <shiju.jose@huawei.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Srinivasulu Thanneeru <sthanneeru@micron.com>, Ajay Joshi
	<ajayjoshi@micron.com>, Senthil Thangaraj <sthangaraj@micron.com>, "Vandana
 Salve" <vsalve@micron.com>
Subject: RE: [EXT] RE: [RFC PATCH] rasdaemon: Add page offline support for cxl
 memory
Thread-Topic: [EXT] RE: [RFC PATCH] rasdaemon: Add page offline support for
 cxl memory
Thread-Index: AdseIOfbJEKPvJ5+RCqFn2Wf/RSCygBjlkbwAVhKVaA=
Date: Wed, 23 Oct 2024 06:09:08 +0000
Message-ID: <f5389cbe39d243aab8f87fcfc70ee46f@micron.com>
References: <a4cdc0ddd56c450c9bfa1d950a3a37ac@micron.com>
 <9ba3aa9d658f48dbb443b36380b61f05@huawei.com>
In-Reply-To: <9ba3aa9d658f48dbb443b36380b61f05@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=2409485c-3fe6-4041-81fa-eb0b06ad3fbf;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2024-10-23T05:57:28Z;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
x-mt-whitelisted: matched
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|BN0PR08MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2d8e0e-9077-45a5-e361-08dcf329373c
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOUGU3WU6n28Fb1vcqk9Q1P/PqqFH4Y7MtLfENF21ZvUDa6p7y5ns1AfD6Kx?=
 =?us-ascii?Q?4ltiPE3Wye1p97kQ0OjXm7Q7yDoe/o6zeUPK2bxCHIyIDdfMDEVX6IztPL4X?=
 =?us-ascii?Q?mgM3x2enXY/6whAqXxGfUdkqSqW2OB12drq++T3tWq2nXObcAt2H8JuOO/6L?=
 =?us-ascii?Q?Ci1xSMsJgXhWcRY+jRBenZkGmfNCJUdFHWG/3iqUGVwvQNypAFCcUQBKjZZp?=
 =?us-ascii?Q?wjeiemCd1PhVfK6hokzFBmFUQOOENupHtQhOjcnraioE/N4pNm3oIh2L5Pj5?=
 =?us-ascii?Q?HafzgUgRxZCaQKez4g1Omf1cG9+1huk77spSSau/HAcLoe+alUhsQH/aLspX?=
 =?us-ascii?Q?eINNjD6dHEP/05A//O/lTfkzEDOqGIecRZnKJBe5qwlRKRhQ2FIoV8IBXLhc?=
 =?us-ascii?Q?nUtH+O/Se9tKJO6X31uHI3g+KxJ/NfQGM9MBe2zohTX1ED33XuRkRdb1CsGO?=
 =?us-ascii?Q?foAZO5wA4lEkrvZa4U8ySe+8vVdselr5G/1jOjqpCvJ5PXYtdtEHmn0yMDk5?=
 =?us-ascii?Q?XGZ9YfaNzMnWJCrgXFBXJho2/06m/YaApIC2orZdFotosT6qvbDUbG16mir8?=
 =?us-ascii?Q?NjObCTOlCcF7t30OrUTtBYiqlsoYvSy7vRl+TGE7ORIqVUqyG/qp35wL/dCs?=
 =?us-ascii?Q?c6lZc0cu1YuBqAHVMRDAHe7AKMxVvlaXkgpLUsPhExO671z63/kLvDEYSbCs?=
 =?us-ascii?Q?OlJJO/t0tCf25VJYZhcRK0qDYcZxSonpG2cW1egQvhGmIuP3qxnIL8+NDn5q?=
 =?us-ascii?Q?0GUCNsnlnd7BWvUsc9wR8iNbZnaZTw0evo/8FV0KPXyNkcMnUcRWA+wWayEf?=
 =?us-ascii?Q?LO8g1xtkAKVyHkaHSNZI1+W476jOGg+V4Pmcsswx+VDdTgUXK27rCV3qprj3?=
 =?us-ascii?Q?g/k0MjZ3z6TkYHKvAPvmP6f9aqiw+44Yxxc46jtm5QEzudZXY0ZsolYS4bUA?=
 =?us-ascii?Q?4uS2nixhJ6TwBHBs/cn4JbyuEGivniHEm6Jv07LIb3z2E4ViHwa1ajvzd3MZ?=
 =?us-ascii?Q?U6kd/oam5lb56vbzRQ6ru2i8OlC1n9Ejuzw9+xCev1xctWwSAtaqztRxgaZY?=
 =?us-ascii?Q?Bv6+WY2fHvkbSA4KbpFrGX8l0LsCGA0OofFmTBAeUAPHo5aB2BG5Jq4g1kmJ?=
 =?us-ascii?Q?xlVCunqdxxGSyznKIXP2qmDB2V61Qdzm3ejT+Aw8OrBaXfnJtlQOOKQ7HTae?=
 =?us-ascii?Q?WzdLQrE6BEBbwjmCZhke+EiOREqhHGGyaoGJpGg1LcNsWYC0aHqW9pqBbDPN?=
 =?us-ascii?Q?JFOqDb6feugT79Qiidece/ZkTtRTomA4s/yJM0DjJpao8yh8AtAK0Dbd9uXt?=
 =?us-ascii?Q?+ZvTJAJPPfOEM/CGlvSQpI3h2SxV3vkIG4vrf/m3agjrOpmTCVfdZXefLxXP?=
 =?us-ascii?Q?CoSACDU=3D?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 06:09:12.5088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2d8e0e-9077-45a5-e361-08dcf329373c
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR08MB6901



>-----Original Message-----
>From: Shiju Jose <shiju.jose@huawei.com>
>Sent: Wednesday, October 16, 2024 4:16 PM
>To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>;
>mchehab@kernel.org; linux-edac@vger.kernel.org; linux-cxl@vger.kernel.org
>Cc: Srinivasulu Thanneeru <sthanneeru@micron.com>; Ajay Joshi
><ajayjoshi@micron.com>; Senthil Thangaraj <sthangaraj@micron.com>; Vandana
>Salve <vsalve@micron.com>
>Subject: [EXT] RE: [RFC PATCH] rasdaemon: Add page offline support for cxl
>memory
>
>CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you
>recognize the sender and were expecting this message.
>
>
>Hi Srinivas,
>
>Please see few comments inline,
>
>>-----Original Message-----
>>From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
>>Sent: 14 October 2024 11:11
>>To: mchehab@kernel.org; linux-edac@vger.kernel.org; linux-
>>cxl@vger.kernel.org
>>Cc: Srinivasulu Thanneeru <sthanneeru@micron.com>; Ajay Joshi
>><ajayjoshi@micron.com>; Senthil Thangaraj <sthangaraj@micron.com>;
>>Vandana Salve <vsalve@micron.com>
>>Subject: [RFC PATCH] rasdaemon: Add page offline support for cxl memory
>>
>>From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>
>>CXL Type 3 device implements a threshold for corrected errors as describe=
d in
>>CXL 3.1 specification section 8.2.9.9.11.3. Device can set the threshold =
field in
>>the DRAM event descriptor when it detects corrected errors that meet or
>>exceed the threshold value.
>1. Better mentioning Spec section and table for DRAM Event Record.

Sure, will add table information too.
>
>2. Section 8.2.9.2.1.1 Table 8-45 General Media Event Record  has threshol=
d event
>bit
>in memory event descriptor field. May need similar page offline support fo=
r
>General Media
>Event Record too?
>

This patch mainly targeted for DRAM events, can be extended for Media Event=
 in future if required.

>3. General question, Is the threshold check for the corrected errors in a =
CXL device
>    always supported/enabled? If yes, please ignore following question.
>    If not,
>  1. Do we need to store the corrected errors reported using
>ras_record_page_error()
>     when threshold check is not enabled?  and page would be offline when =
the total
>CE count
>    exceeds threshold.val by the ras-page-isolation.
>      Not sure how rasdaemon get information whether threshold check is
>enabled/supported?
>      May be from Advanced Programmable Corrected Volatile Memory Error
>Threshold Feature?

Yes, it uses ACVME threshold feature, if threshold enabled then flag is set=
 in dram event record,
Depending on the flag, the RASDAEMON can know whether feature is enabled or=
 not.
If enabled, then RASDAEMON will immediately try to page offline. If not ena=
bled, then=20
call to ras_record_page_error() wont takes place.

>>
>>This patch is intended to offline pages for corrected memory errors when =
the
>>device sets the threshold in the DRAM event descriptor.
>>This helps prevent corrected errors from becoming uncorrected.
>>
>>Record the hpa for given dpa, then do page offline for hpa when corrected
>>errors threshold is set.
>>
>>Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>---
>> ras-cxl-handler.c    | 14 ++++++++++++++
>> ras-page-isolation.c |  7 +++++++
>> ras-page-isolation.h |  1 +
>> ras-record.h         |  1 +
>> 4 files changed, 23 insertions(+)
>>
>>diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c index 037c19c..c163c6f=
 100644
>>--- a/ras-cxl-handler.c
>>+++ b/ras-cxl-handler.c
>>@@ -13,6 +13,7 @@
>>
>> #include "ras-cxl-handler.h"
>> #include "ras-logger.h"
>>+#include "ras-page-isolation.h"
>> #include "ras-record.h"
>> #include "ras-report.h"
>> #include "types.h"
>>@@ -897,6 +898,12 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
>>       if (trace_seq_printf(s, "dpa:0x%llx ", (unsigned long long)ev.dpa)=
 <=3D 0)
>>               return -1;
>>
>>+      if (tep_get_field_val(s, event, "hpa", record, &val, 1) < 0)
>>+              return -1;
>>+      ev.hpa =3D val;
>>+      if (trace_seq_printf(s, "hpa:0x%llx ", (unsigned long long)ev.hpa)=
 <=3D 0)
>>+              return -1;
>>+
>Support for the new fields in cxl_general_media and cxl_dram events  inclu=
ding
>'hpa' had
>submitted in August in the following pull request.
>https://github.co/
>m%2Fmchehab%2Frasdaemon%2Fpull%2F178&data=3D05%7C02%7Csthanneeru.op
>ensrc%40micron.com%7C58611d95cc3244d1019b08dcedcfbd2d%7Cf38a5ecd281
>34862b11bac1d563c806f%7C0%7C0%7C638646723730965866%7CUnknown%7C
>TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
>CI6Mn0%3D%7C0%7C%7C%7C&sdata=3DA%2B2H1gyx3njUG5U0p3p2IPzNkcPBfaKG
>QPfvcC%2BZRAQ%3D&reserved=3D0
>https://github.co/
>m%2Fmchehab%2Frasdaemon%2Fpull%2F178%2Fcommits%2F0b396b47d740c88
>fbd890213f2d9d56e566e0671&data=3D05%7C02%7Csthanneeru.opensrc%40micron
>.com%7C58611d95cc3244d1019b08dcedcfbd2d%7Cf38a5ecd28134862b11bac1d
>563c806f%7C0%7C0%7C638646723730965866%7CUnknown%7CTWFpbGZsb3d8
>eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>C0%7C%7C%7C&sdata=3DdjrC%2BSZVrrxsZ8IiC2RJ3E5%2BwZs4QYtqulVBdgPrnyU%
>3D&reserved=3D0
>>       if (tep_get_field_val(s,  event, "dpa_flags", record, &val, 1) < 0=
)
>>               return -1;
>>       ev.dpa_flags =3D val;
>>@@ -1005,6 +1012,13 @@ int ras_cxl_dram_event_handler(struct trace_seq *s=
,
>>               }
>>       }
>>
>>+#ifdef HAVE_MEMORY_CE_PFA
>>+      /* Page offline for CE when threeshold is set */
>>+      if (!(ev.descriptor & CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT)
>>&&
>>+           (ev.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT))
>I think alignment should match open parenthesis.
>>+              ras_hw_threshold_pageoffline(ev.hpa);
>>+#endif
>>+
>>       /* Insert data into the SGBD */
>> #ifdef HAVE_SQLITE3
>>       ras_store_cxl_dram_event(ras, &ev);
>>diff --git a/ras-page-isolation.c b/ras-page-isolation.c index bb6b777..6=
eb45d0
>>100644
>>--- a/ras-page-isolation.c
>>+++ b/ras-page-isolation.c
>>@@ -338,3 +338,10 @@ void ras_record_page_error(unsigned long long addr,
>>unsigned int count, time_t t
>>               page_record(pr, count, time);
>>       }
>> }
>>+
>>+void ras_hw_threshold_pageoffline(unsigned long long addr) {
>>+      time_t now =3D time(NULL);
>>+
>>+      ras_record_page_error(addr, threshold.val, now); }
>>diff --git a/ras-page-isolation.h b/ras-page-isolation.h index 73c9157..e=
d2f661
>>100644
>>--- a/ras-page-isolation.h
>>+++ b/ras-page-isolation.h
>>@@ -57,5 +57,6 @@ struct isolation {
>> void ras_page_account_init(void);
>> void ras_record_page_error(unsigned long long addr,
>>                          unsigned int count, time_t time);
>>+void ras_hw_threshold_pageoffline(unsigned long long addr);
>>
>> #endif
>>diff --git a/ras-record.h b/ras-record.h index bd861ff..d4969d1 100644
>>--- a/ras-record.h
>>+++ b/ras-record.h
>>@@ -203,6 +203,7 @@ struct ras_cxl_general_media_event {  struct
>>ras_cxl_dram_event {
>>       struct ras_cxl_event_common_hdr hdr;
>>       uint64_t dpa;
>>+      uint64_t hpa;
>>       uint8_t dpa_flags;
>>       uint8_t descriptor;
>>       uint8_t type;
>>--
>>2.46.2
>>
>Thanks,
>Shiju

