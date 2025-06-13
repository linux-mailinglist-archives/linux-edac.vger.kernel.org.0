Return-Path: <linux-edac+bounces-4141-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B9AD94D8
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 20:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BC13B5433
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EBB233140;
	Fri, 13 Jun 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ywz950XP"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683652236FC;
	Fri, 13 Jun 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840816; cv=fail; b=IlxfbMW5I0QP2A2ehrJQRSka6SqBo9ETU0Gv0QOwB+0SMl+MFbksRfDE5gYawh2A0qKs5PGnBeEPcXiYS/gC2c3oiacj1hRQimg0eDeYS9TTSpKSdOxaR6loMv4HL3olRlyUtBI8TP/WPtNo1AXXzLMOxJy6pMHvdoxm5VQhkMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840816; c=relaxed/simple;
	bh=ox5g4bTwMWKEVzo7ZKsn8ktQaIgR8vyL4ziXQOpSuws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ee6zCqsI7Xsoz/1k9q/3fNNKVYHYl4TSDLsJhXPE21/gmM2ulzxg4bG5C1QDLawHIF1KuTkHK7c/yw3fiM0LQnBi5In1h8D0s07Zxz4V4yYuGrfAa4uNyWec/+5KDky6y4x8KFpjcIxYlx/0qcJm162Eh9oTNFnQLvwjhlYz5fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ywz950XP; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7blMo4UDWo8y87xFZtJrEy3d8gBGg6vznm3eo7VuLcfhqNEmGvWhg6I1dwdcIgfb9SB/YPLjL5/wUfjt7taJVd1KJg0uyhgLsbUl9cDG1lJXN0fo08UILRfcgAnN2C5E+mSX8SjFArKfQq8wIze5kQodXmRCUxo6oiwJ5q2FTqx8xJq9Yz22GgKLStGJMFXPPCLN6lqGE5ELOqVl9ZDKrRGMltY86D19q9abZOdlzB8Y3602z5U62BSIRxhLqB2uP8+Xjr5R8OgHO0sKA6quLZ1QMneQHqLEptXUZvE8ZPHKgvFLzUUNtpq61PuXbpl72I8UKZirHLjdBArPPVJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mCT9vMgBpynEJ4/deRH2QCjtCi7NyPR6xmuY3wYi2s=;
 b=QHJXjw3GFr/C2pzSvcPqyLAVw9yyNwC/NQwacc+w4EJ8Vr5ncuDYTLfUosmu5gRYFq1eNcdPskNs4R9GnYropnQrWX/vRIRgEMbVTZ9cemABXzQ21Qiwoi4vlCBy+tulI9vPqyH/z1+tdf6s82btCpWea7sRExnFbT+Wj7G29ya0H3fTIGvW/n5hhJm+98f8XytWbHG2Tvx/dbe548ulKWNpzCqihOZlMX2cwiGtDk1SSNB5pj11Y89l3JuQUWG1LEH4x2eHptNJjf9AjHARM43Fz+pdO39TLEWxpffoiv9mo9+nxX0Me9LXmjBHKGulsEZclHJTsxiKiPTzuwRuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mCT9vMgBpynEJ4/deRH2QCjtCi7NyPR6xmuY3wYi2s=;
 b=Ywz950XPwmnSms9JR3t9zXGUyHy8Qi7f3Dw5mZ+bClb1oR7Kd2vZNpAioAiPijWVFSG23HQtV64rP3BGbZ42MX9IAgwAudiwx2RYw0KzdDj1uETcKiAUGHXjIC67eKNnWIYL0iT+jbdXath3c0vYepfHubpFC7yeTNHdi9QbZW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 18:53:32 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8792.038; Fri, 13 Jun 2025
 18:53:32 +0000
Date: Fri, 13 Jun 2025 14:53:25 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v8 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250613185325.GA171759@yaz-khff2.amd.com>
References: <20250610123725.1652-1-shiju.jose@huawei.com>
 <20250610123725.1652-2-shiju.jose@huawei.com>
 <20250611190136.GB288240@yaz-khff2.amd.com>
 <3fe6a12393f34bf5870313b59fa39e11@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe6a12393f34bf5870313b59fa39e11@huawei.com>
X-ClientProxiedBy: BN1PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:408:e1::28) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f486aa-a015-4e05-e8c5-08ddaaab97ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YHJ4G3Dqq6m0PFWGUiKG4lRglt+bmWNbgctqnh5dhUibRlKWU87VmNLd456b?=
 =?us-ascii?Q?kuwU4b9clanqK4jGMg7QFawmmhw+4RyXt4KCyTQyfyGzFJQ9UKI2BDGlAyVX?=
 =?us-ascii?Q?dNsGTAA8NVGobxrKyZWjkkucSMSKMEyLkkDYehVo/rHrb4nb+o2Ox6pL/fqy?=
 =?us-ascii?Q?EbzsoI6u1rjAHoFMTbJNAhp1+gs6FmgXw7VVMey7Joj+tNWShsGrcPz4H2/a?=
 =?us-ascii?Q?b4q+cTQXOpHOQKYwi8BHb6FkGnAitWuUHFFY1swFmI6AG4lDpGl6Sva4kNx4?=
 =?us-ascii?Q?LUhS+L0T+tqCO5Or76Y/XWsMfsfgNo8Sur9xkOLcZyqf/ayBDKLNUOpw5IzY?=
 =?us-ascii?Q?1/ZukWPcN2YblmdfORwxw7dxFYrHvLK82+KLv3dEe6+4O2wMRXarx50LKcwI?=
 =?us-ascii?Q?2Pz6AB3+5/j4fVcvgygoZ72FGyphye0q5dzHSyClFjDGGl0SXsJHjFlC9gh1?=
 =?us-ascii?Q?UrxSTqy28fC8SkcoXa88NhAKkfMDrdDxE3veIDwVl/yo+hQohUkEjQcJIQ8T?=
 =?us-ascii?Q?WnApXubkUQJooZfPbXNjWvm+BB1oAaRESZdsnJkb6ECAWW3FfqcpUW3rOEJl?=
 =?us-ascii?Q?vDUi1ZBDEdai1zmPmVbcMnI0Fghfqf4RCelYqgSyUa4/fXhlm9YO1bWnkm1B?=
 =?us-ascii?Q?dTixaxbxgozUupsIsIBiO3IXvKTyXIGrJfhQQODM0Bwqp+z3NVb1iffGFhW3?=
 =?us-ascii?Q?tRBOWGQ1d7wW70ayIvJb2o6tWDxgzBllmiCyjq8hE9r184V/tPPBjxtSy3Q2?=
 =?us-ascii?Q?9BOuR2Yr9kXhrVvBOvG89gk+NAlP7bJh+XIZP/m69lNfBTSRIPnc+O7XekSB?=
 =?us-ascii?Q?8L2QgXitvHj7CjGVSj+ZTC1Ecl+WyZypR3NnW5qBkmAiKMEz8dE7D+e016/s?=
 =?us-ascii?Q?p/pJsFTExZd73fg9Mmy/SKvPFioiD+/9tRYriMMfmYNfPtrJroY6E4Vz5coK?=
 =?us-ascii?Q?QyWJ77q4aCyerd2QEF9cNVA+5f7X2iV2xOWEmvKramR+cTUUMoAgKb+NBOIB?=
 =?us-ascii?Q?PsNo70HlGhyLd/obsWpHNzDlxPOdvh+C9ypzrekkl/WaLCCscNDoEOGveL8e?=
 =?us-ascii?Q?aU0yPP+v3Dmv/j+zziWPOg0S+xQfJtJMkjGN3QvkAIPrb9rl59a+nm7OFpun?=
 =?us-ascii?Q?z4W7XRGoKLcX/AL8vIwLkyjydfOluvS7aXl+p1e572FXF9ARh6oYWuIHZt2c?=
 =?us-ascii?Q?LEqSvAWO/uNMtbAbZ5oy7eKywkjBw94p+FOZ3EN5NMwsTHBU9s1gLS6otr7P?=
 =?us-ascii?Q?hUygdx8iGzZLgSc3QduxE/hBYfxZY9CfjJAQnjRC2Q/wYXggeehHXaeLAGpT?=
 =?us-ascii?Q?HzBqQAj0RhQ5CpcywVgZc33bCCeEiL/o8oOfYkQHkpWy69YSx9Q8a2CIwM0j?=
 =?us-ascii?Q?/VtrcV/Op7EPY9/s1TjW4EgSx+47+45QPelWGmIBVNmgFXXGx81A74R9aK9J?=
 =?us-ascii?Q?KRWLExE7DBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1VL5twhsPbGUvEFe8KfNjaom0hwL2f7SJMmeKmNXGxvPHqDDrwrV8edNKdzh?=
 =?us-ascii?Q?6bU6lVRIPMAEG43V73Sn7dpbLe4qsqE9AhRieJT+pSUYA742XgEuIOeCLoex?=
 =?us-ascii?Q?esKS5VAxYbV0AWdhmvjsRc0FUIiqbdhagaQbs5FHhP8tpayKE0at4ejdglYB?=
 =?us-ascii?Q?Z/SVQf3XieGNuIC4+6hDdpB4drcx/zoyktge0EGWw4x9L/t5KxKwGxKs2w++?=
 =?us-ascii?Q?cDQqnaXXKPV+HjNeg4LAWB9mINvBqNdmeV2lVZFR3W4AcStF1dU+QMWd9xK6?=
 =?us-ascii?Q?cQQ2J8r7IZmlpokZzSMJPePKZD1aKOOAi1dosN9W7qfZvWfYs9eT8jylYT13?=
 =?us-ascii?Q?D6V55T8Sh3WKjsy4MWZiBPMGatmGGCzNaCOj4Z4DX8X/dqB34oN0pMugOr2e?=
 =?us-ascii?Q?fBbM2+DQhhqjidAVZfMr5GNbiq4u/QQFCgrK6VivgmHRBH7wcIs27XrahP/W?=
 =?us-ascii?Q?+rvzsz62jOL9vCX7g4Narft8at3YPy+ZVkxAr0IJIqCIME22xcgAO3NuCxOu?=
 =?us-ascii?Q?MlWYYjE7V7jy4Dyv6tHCWHETzJKe/w91d8sU0DixD9n9z4lI6M8NS07/8Hxq?=
 =?us-ascii?Q?LH+uEVSKHu8L7qBaBj0a49ilUoX/tnHUNdAesgsR060RInKAmecA1QngqRqZ?=
 =?us-ascii?Q?lmhu3dz9T+CehttpZVfcb6bU46WySLqJ6sgeCW6W/n/yVUOY4Q0o3bR1y1cf?=
 =?us-ascii?Q?1KFWI7PiD90rQToWcH5+QECYcu2dm4OfG18TETezOYC7jOyMRxkaVEyxiWzG?=
 =?us-ascii?Q?eh6O0je/88PuWKnytIm4E2TiMfiv271sMfzDcHr6XXBbHEsnRFj8qpwVyjTK?=
 =?us-ascii?Q?sQN7dGkydmFEqO5qoj4WQ42DoUyQvnRgix9K744jgLd7jPjjtMSJ6gYQd1ZQ?=
 =?us-ascii?Q?hmuNRmk9FviX8HK/hp3ZwMM+d46K68riMzF2Zx1Lv90sdhLXEUPuO26YMZbw?=
 =?us-ascii?Q?yE1UKql+5hH/oPK2mYeVm+AEJMq90keYzBQuXoUtpiQeL9p2NwCtETmWjwes?=
 =?us-ascii?Q?jxFiiBIlVsnA5fVT9FBCmWbzVXCXicjst+wKZK8B+fXabF1L0fugGSg8PRjW?=
 =?us-ascii?Q?Q/rEmAveNf6EqB4DLgVWHT0L+nNG9wkwW6Br2NJYqCzHbkqbrvVZzr3ZDLF/?=
 =?us-ascii?Q?wv/ENnF4vGxadp/QxuWqZ/7UlSzih8jQDl3O1eb6B/EGFJxfpO1bQwBoy4En?=
 =?us-ascii?Q?NOIMsCLJzdq9gyF7rzkCUr/87SRpBM91G25Un9ftZMyEE+ZlesoTGdWJC1wh?=
 =?us-ascii?Q?+9iEmB6lJsrKj7UvWUN/iuFJrkx5BKIQUG71l/ddxFLeHRapFAI7rmx9rs0/?=
 =?us-ascii?Q?MwwOw+OojVldNlNlB2c1gHbtrjF+Lb397LBEIxVGj8uY61/uujzEn8P5nezh?=
 =?us-ascii?Q?APHmd8TtFxQUh1EfcoM9UAtqbiIavcrJr5xT6YWxTnprdKUJcDTjU1gsMZkC?=
 =?us-ascii?Q?opUyTvPfOUqIL5FJVkqHn6NwsLqKfq5p9SKNd7dBcdRkshvC5jioFdfUuR7/?=
 =?us-ascii?Q?BtbZkP7qRBzpbt+XTeuQK3ZFKaGOFhN6uA8iHNU1YXSVzyN0nJjF5VHqP2hJ?=
 =?us-ascii?Q?PpPiKe0a9dkvZ2+tbff5wkUrn/1YzbFVV/rJlNmi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f486aa-a015-4e05-e8c5-08ddaaab97ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 18:53:31.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlCOz2kHxwVWdA0MlGZ+ooVuRac6hNPISlk0ugHpmjNf0+K6B6pwqxa3XK12r1ZwVzUHRVjyRuxQO/Ox4rt30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

On Thu, Jun 12, 2025 at 04:29:50PM +0000, Shiju Jose wrote:

[...]

> >
> >Just curious, would the new "faux" bus work for this use case?
> 
> I tried with "faux" interface, following are the observations.
> 1. RAS2 scrub control interface do present and work under /sys/bus/faux/devices/...
>     as expected. However it does not appear under /sys/bus/edac/devices/... as required.
>    It seems that the reason for this is that, with the faux device, the RAS2 faux probe function 
>    and thus edac_dev_register() is called during the early boot stage, compared to the probe
>     of the present auxiliary device based solution. 
>     I think EDAC is not fully initialized at that boot stage?
>     This issue is solved with late_initcall(acpi_ras2_init) instead of calling acpi_ras2_init()
>     from  acpi_init() (drivers/acpi/bus.c). 
>    
> 2.  The faux_device_create() function takes a struct faux_device_ops *, which requires the
>       faux_device_ops for RAS2 to be defined within this driver (drivers/acpi/ras2.c). Therefore,
>       registration with EDAC for RAS features may necessitate moving to a *ras2_faux_probe()
>        function here. This would also require moving the struct edac_scrub_ops ras2_scrub_ops and
>         the corresponding callback functions from drivers/ras/acpi_ras2.c to this location.
>        Alternatively, we could add and export a ras2_faux_init() function in drivers/ras/acpi_ras2.c
>        and call it from *ras2_faux_probe().
> 
> Thus not sure  "faux" is a suitable interface for RAS2?
> 

Right, maybe not. Or could be something to look at later.

I only became aware of the "faux" interface recently, so I just thought
to ask. :)

Thanks,
Yazen

