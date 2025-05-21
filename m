Return-Path: <linux-edac+bounces-3985-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D5ABFDB9
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E58F17175C
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3A28ECF0;
	Wed, 21 May 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKyppORJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01522B581;
	Wed, 21 May 2025 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858648; cv=fail; b=qTBOY4flgr+MC4yXWkrIgvvoBuGmjY6VOpYpCDwDo34S7LdqqcexYg88b8KVSpshTVWOLxEKnWOT3Wc3pCkbcihhvoRRV32Vz7qmUS8sBrws9yDlTNVyaW/9BW4xdYMix1Q8XUxgslL8/8ws64FnxAX7E8uXKCe/E0EHKzclDfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858648; c=relaxed/simple;
	bh=XtbAdtJw4Bddh77WfqvUWzqfHfIx4Z71tI6X9ax8np0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iSUJD5dNU4hCJ2AmsWufe0iNQIxk/9Ki4hKVv6U4PVzD3gM1iml8TO6pYTpcF0Iwdx4iPIJcwrHG3oPEi3/AEY7+HQk+F2AIka8pX4b8Q1sGCh6uIO9fR/K4xahJPGczOXIcTqm3HtWTYx7WMoU7k2Oa1czWjJa8u/jwmEixc+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKyppORJ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747858646; x=1779394646;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XtbAdtJw4Bddh77WfqvUWzqfHfIx4Z71tI6X9ax8np0=;
  b=bKyppORJvx1Z22Zmwp4u1bjjt/fiNc0NvbQldgSdPK0x1bNMnySWusXu
   PMwqgmqlnmicjDHVDr2LTIRLnoiMNPOqGwCWDf1S4yk56hm77TzRj0xJa
   4D4dvNjczwm2K68sQGTE8zM3epX/E304l4LqplD6nwk6U12ZgOb2VjSY0
   F3qFR8XfPdh8WRlrkK6nIDVBnOd6tIFx7pMGBmKn2wXhAuA0bnr/a96KR
   YbqsfPcN3vP3KSwIkKFpoMjiyYslXKemGcPP1rMR/R6NsVaLuf9wuiJah
   wkHhhhsJvJc0s2X78kjI7JrNxRXjl1us3no9/b1HNdVWrVEb/owHk5+5v
   Q==;
X-CSE-ConnectionGUID: QpuB7wJkRa+5uSJlxrKzDg==
X-CSE-MsgGUID: RaUJYl+pRc2KURQPMJOFLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49561854"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49561854"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:17:25 -0700
X-CSE-ConnectionGUID: KYdmpQOhTbyP2LF+H2B9ZA==
X-CSE-MsgGUID: 2F3nZRyxSkqwLHA03qQ+Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145362725"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:17:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 13:17:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 13:17:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 13:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vx4G0GvBRs9NvJNfazu+QDrI63SZ0SwOmeUijvGe1iuuAGXba/Qq4SDWy+o8Jhp9ROkEyEH9wR4dtkwMyZP3p3gL149JKRdo0LOkrKpJ/uKOlbb1TdHFwDSenbq5PjzirnU9Dzi/CvVr9Ilvg5IMSLJiSB1e2ZAM9+1XHerCXtOts53bmF7wUD2FblwscfWZ9r1pwp7V58vF95BkReGyWD/pHIXpqXk6Ru3UAQroH+RiDv64sNYYjx3UTwvtBT31zfS1VUbXjMrBmOnniua27Dz9HErkvFZEUtz5aK+UC9hEVB1GxSRjTnKd5I3fiKzrvcQ3CvGu4MtXG/FWhMmCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bTWTGATTRJnlZewRQieEbuLhJRSrtgiBQkQ92C+VSA=;
 b=UXWa5C5S7H+DZUzzRmrF1nGXhS53Zuc7AsdbyXxXwymMUiDjKxV9rI2UGRoHfB5hpYiUH395vKGoVNqORaIEZoK52rH3vzpSFSa4tNxZLgY+B+peLcD/RY4Vnx4SotVjTgZ5kpajnm0+GYOfIR2imzORgwOp3vfjGlS774lIaAuw0qqrc1Ellen2xOV0IoEmLpYxGv30lI3sqlt0lT6gQenfjEKZGxl6h47ZoksbFBN7P0he0TY27Jc1Td3Puhb0WBetfsvYFdvbM1q88KXkIisCyCrPAJXxeu2I/oOvmnJqX9UqqLqe+eRepficorLH+2UZodVqTtE798o7Ptq/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 21 May
 2025 20:17:21 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 20:17:21 +0000
Date: Wed, 21 May 2025 13:17:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v6 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Message-ID: <aC40zc_tzHT1QM6p@aschofie-mobl2.lan>
References: <20250521124749.817-1-shiju.jose@huawei.com>
 <20250521124749.817-4-shiju.jose@huawei.com>
 <aC4IbZQrhmL9PohM@aschofie-mobl2.lan>
 <20250521184847.000021ce@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521184847.000021ce@huawei.com>
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 28309229-7bff-455c-cda8-08dd98a47e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x44MeyCcPzaUTnQcG/jM71EtIWSaKNI8beYbViiBxvOkx9qCPunXW6stncI7?=
 =?us-ascii?Q?X4ZOG+dsUZlh/+LqsW+v0PO0UAQSGKD36Hdi+TiwefArlMj6hwpSGanG954c?=
 =?us-ascii?Q?zNtSibHqWY6UuqZW9idysfAzpw/94pyGJRGEVcUecX0qYOxEoQwpZMvniLMH?=
 =?us-ascii?Q?7uaBt3zLdDzOAj9RUS6hs1IwQV2vXdYq9RyiYigj7dusPj1Da1sLD78Cs+ot?=
 =?us-ascii?Q?jXeUEk+oWVhrpIV/oZOLQPX1pjMuvsPniJ/VT2EU82sS73yV8WtlsPkR6ti0?=
 =?us-ascii?Q?z4DQjJni3KMYUXHew5AX9ZK4/x80u4AZDy7blh0b4POO+Iu5uWJjO2b9lWf4?=
 =?us-ascii?Q?r89kqE65qymN8MSQ6kLkda/bq+BiwveDZb0ZuNgVBpuZY5Jt2ciPTA6SZpJy?=
 =?us-ascii?Q?naX3rBDCNhKDYbCkVCpN2pPU/Hu27ob3KOes2nkJKOIesitNwIlPnZ1HTNWr?=
 =?us-ascii?Q?K0k9WnLfIsiC8F6XBn9qGn2o0IJp5FaPNLRGjm03tZLABsqZ3vGKZaGMlsY7?=
 =?us-ascii?Q?eWDrqVGqOznS+gvF5iLGLUh+XRqndEzTJvuDyw9ZUQIIW5yZrKPF4j/Wsbr/?=
 =?us-ascii?Q?iuhucVCGOovsJJKhSh/M4e0g05W04OedEu1QG9gl7A28se6I0R3OCrgSaqCI?=
 =?us-ascii?Q?WABFzolDQ/RtAoW43pWurVE6yM98Tn4+9ECId9fdV6osoFUZJyMKGxMWorQm?=
 =?us-ascii?Q?hjQSfnPgaayal7TPJkJ6Yz7gwhpoCxPj9P7fijbSP6NxbzXuJImAsZLfoWhu?=
 =?us-ascii?Q?8uwecl3lBCC/ynsN+0TvjgjI54+lZITthxgr8CjueRfmmwAAEuyeJJ66zVHr?=
 =?us-ascii?Q?Q7aeoEBUFrvmW81M64OWxod4iCR9roKY1bXomizaymfpUUr8Rn3ixexHJK50?=
 =?us-ascii?Q?8vGNrS1q2+g9pWYzBFK36rzDbyIrla+Hg5uSF0MAi2i2XDXZbEL+Dx6zzZE3?=
 =?us-ascii?Q?M0mVmHVRQ0rv0nycZOkW9uvi2yeBWtCcW+gJ5+PY5fr+PVwVeM5IPHqUDBWr?=
 =?us-ascii?Q?kLxCWUGE0vLHDe4JPiTSh4nAw8eWl9+s0oeuGchVB42C8VgMgrzlo+GKGCSM?=
 =?us-ascii?Q?CrZRSy7lHW2LnYwkFBrA51Tv7eSFjHjhMlfyuuhWT1I4XOaRjThC6KB8JfA/?=
 =?us-ascii?Q?8neKbcTQSrrqLPq2LE0CTlKfwOpOOokK7sEH/yD+BjKYTTeFdqn6taiMHDfu?=
 =?us-ascii?Q?E90V18kmR22dOfrqn17s0BfL42NP7IoGAHgylq/lrDnLccbGGe3D2PUzTwda?=
 =?us-ascii?Q?HYL/tSjiklOa/KfR6hTKJmdqMTfamma6reeAbqpKx3dNVbAp6+xG+NtknchA?=
 =?us-ascii?Q?WEx9D5XbykeR5K5mHAimVhaLNaejSqJMcixmZ1cJWq1xkhVQbtbugtGHrJvt?=
 =?us-ascii?Q?28zVhv85SStE7C8tYAMQOHGFq/yFDT5fhqAPa+OTs9Qhsg/B4SWdpy1Dh29W?=
 =?us-ascii?Q?O0ucOJnQDY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?egqk/o/AKg8s+tEdRRlqBaBNNhYRLPiva/44Qy6ALfDUjqGFcEgTI8mssZmQ?=
 =?us-ascii?Q?p4qKwxBvxDTosFVJj/jjKeQLZACyj/duvWGhp6cB2LIM8ZInvw8cTFoV62i5?=
 =?us-ascii?Q?HEUvzjNl6OOGnU1XTciXd/4voblvTsCh+Ifq47A6am3CE8GsNrldyaR0ocYh?=
 =?us-ascii?Q?Msme6TPp72xZjlknk1YpnuK48Y2iT2vT5NdK6/uGd5xSSJH6CYu4c1oumv2+?=
 =?us-ascii?Q?7A9Rs6yjJ0G0wdK9ArRGjqULlLCTvbsrMylvoyGk+uflgE7wCPaSVimaF/SR?=
 =?us-ascii?Q?apFEsV9/t8BEgJEssItWit6v8DD8FqWcyBBi3o4mJTmHSDOb5oakIzqFtahE?=
 =?us-ascii?Q?jYKUKwDFBqCIcbRMOxTlxL7gFO4/bJVZDErYmittCuPIY0Qh0l+V67z8SD8g?=
 =?us-ascii?Q?mYn26aikWMi4EokmlIpoIyKCGhSAeQFcibMhcPZOsXcPU/MtIGRfAVDpuk92?=
 =?us-ascii?Q?kYABqJZyJ5EUJC4WceEBV2m2rYh4fiw7iBwWRKnsUlf+Bk8DQ3zykFZIKSi0?=
 =?us-ascii?Q?lS4w0D4o8kZuy24GPYmWfj9bq4eRv2Nvbu6pTB1pBmHTEw+m4mp7FVMtC8ja?=
 =?us-ascii?Q?9TvgmSGcYk9kO+6Q/FNmATAVgqB4Yt9Q9YS/YCfZMXD4aG4Us0S0oVDsJOp6?=
 =?us-ascii?Q?wv/A4E61dbkUzYB7En298hWsW/l+rxnWVs3T06ZFLbD3ycY9sYyklUo+xq4V?=
 =?us-ascii?Q?d3p0wzkFgSg4F6JYAedYFT0j4DkE+O1f0Z9/+5VptAaLebUryQ5uCDGEtzNq?=
 =?us-ascii?Q?XP5INGoyxVDFBfGnpbxydD4dzoSagWVRYMY4VFu7uVTIUgS+QByI9DzyyVtR?=
 =?us-ascii?Q?43Ptw+vOIhP6691XrlRfsgqQxeUDDgCJdiHllxAlrgB6Cnx4m5v6DedVy0Cf?=
 =?us-ascii?Q?FUQjDhjZdSuW9GRaziRKC+HBcuAN6+eq+py9WVkM0P1EsRr6UXnmcYGveNaE?=
 =?us-ascii?Q?dvW78ukuuORfOui8Xthr+1om+Jt3xYQgdNdZgXw2YQgSkNTC+X6oRpBgRAYy?=
 =?us-ascii?Q?52T/Zwgzod4x+FnmlewXwc7Njy2Fl3MEQC7U6+wTUoQ19XmiqDL+yWSwxR2D?=
 =?us-ascii?Q?EchyeB3al2LJ8Dc2dR3vI2s7G8es5+dfqmA+BezbefHmIGD42sYNen3LRNQC?=
 =?us-ascii?Q?toFOvXCwpYG4C4Wq8TnUv/LIFTVGZLeUoZHCRHWpEdMrda5QJjH19brA4Ac6?=
 =?us-ascii?Q?UkNWThoeVzZyIvVnTScUl8yYBwwaRjPSvVksnXq0Saqtj0V5cwI69cST/032?=
 =?us-ascii?Q?EMDxavz5HqgTdO28lW6/aCqv1fp/Q0ccWKXHMkZT1KdAiVVilF6k1aUEUMT4?=
 =?us-ascii?Q?LRrdrxScAjCViGLQmkXVyCQVfAAEk4J/74GGdq4jIDv0hnjl0kjaTpHRvu+Y?=
 =?us-ascii?Q?H9+fp46A77VaCMLKBSKCud88HpOSKqDczcruWl9mRGWD+DrkMnssGa4G9hcs?=
 =?us-ascii?Q?QvenaQuJsTQ/vrZudrAIOfMscXMRzpXt2DlF8QnHNe4M5qe9OEdAYFaYYu8w?=
 =?us-ascii?Q?kvIpBMjdF6H3NCr5wbcG12ARxnAvsDBgNU7OBO+J01UdY/0HaEW9FKPVx4XO?=
 =?us-ascii?Q?0+O52a8mv/Y/k62gvxdkmcGyh3JgdteUGySZ/LCL3/M0C3uolzYfjpXGYOhx?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28309229-7bff-455c-cda8-08dd98a47e1f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:17:21.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZCbzYnSjOzN9uUOcqm1xIvxFopwMTTK6QO3hrKqe6jQ6xGCIuN9AAF1Svfs5Xw9gcLSqWN0xfnx2NJ7dyMbNU0t6D3+R1/21bMkBJj/n+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com

On Wed, May 21, 2025 at 06:48:47PM +0100, Jonathan Cameron wrote:
> On Wed, 21 May 2025 10:07:57 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > On Wed, May 21, 2025 at 01:47:41PM +0100, shiju.jose@huawei.com wrote:
> > > From: Shiju Jose <shiju.jose@huawei.com>
> > > 
> > > CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
> > > control feature. The device patrol scrub proactively locates and makes
> > > corrections to errors in regular cycle.  
> > 
> > snip
> > 
> > > diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> > > new file mode 100644
> > > index 000000000000..eae99ed7c018
> > > --- /dev/null
> > > +++ b/drivers/cxl/core/edac.c
> > > @@ -0,0 +1,520 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * CXL EDAC memory feature driver.
> > > + *
> > > + * Copyright (c) 2024-2025 HiSilicon Limited.
> > > + *
> > > + *  - Supports functions to configure EDAC features of the
> > > + *    CXL memory devices.
> > > + *  - Registers with the EDAC device subsystem driver to expose
> > > + *    the features sysfs attributes to the user for configuring
> > > + *    CXL memory RAS feature.
> > > + */
> > > +
> > > +#include <linux/cleanup.h>
> > > +#include <linux/edac.h>
> > > +#include <linux/limits.h>
> > > +#include <cxl/features.h>  
> > 
> > This needs tidying-up. Not clear that tidy-up belongs in this patch.
> > sparse now complains:
> > 
> > drivers/cxl/core/edac.c: note: in included file:
> > ./include/cxl/features.h:67:43: error: marked inline, but without a definition
> > 
> > because there is a proto of this in include/cxl/features.h and it is defined in
> > core/features.c.  Compiler is looking for the definition in edac.c.
> > 
> > Removing the inline WFM but that may not be right soln:
> 
> We definitely shouldn't have a non-static inline in a c file.
> What would that actually mean?
> 
> So I think right fix, but needs to be a separate precursor patch
> as the issue  predates this series (no idea why we didn't see it before)
> 
> Alison, fancy spinning below into a patch?

So - yes we will handle it in a precursor patch, and I'll submit
Mulling over the options w DaveJ

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index a83a2214a136..4599e1d7668a 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -36,7 +36,7 @@ static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
> >         return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
> >  }
> > 
> > -inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
> > +struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
> >  {
> >         return cxlds->cxlfs;
> >  }
> > diff --git a/include/cxl/features.h b/include/cxl/features.h
> > index 5f7f842765a5..b9297693dae7 100644
> > --- a/include/cxl/features.h
> > +++ b/include/cxl/features.h
> > @@ -64,7 +64,7 @@ struct cxl_features_state {
> >  struct cxl_mailbox;
> >  struct cxl_memdev;
> >  #ifdef CONFIG_CXL_FEATURES
> > -inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
> > +struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
> >  int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
> >  int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
> >  #else
> > 
> > 
> > > +#include <cxl.h>
> > > +#include <cxlmem.h>
> > > +#include "core.h"
> > > +
> > > +#define CXL_NR_EDAC_DEV_FEATURES 1
> > > +
> > > +#define CXL_SCRUB_NO_REGION -1
> > > +
> > > +struct cxl_patrol_scrub_context {
> > > +	u8 instance;
> > > +	u16 get_feat_size;
> > > +	u16 set_feat_size;
> > > +	u8 get_version;
> > > +	u8 set_version;
> > > +	u16 effects;
> > > +	struct cxl_memdev *cxlmd;
> > > +	struct cxl_region *cxlr;
> > > +};
> > > +
> > > +/*
> > > + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-222 Device Patrol Scrub Control
> > > + * Feature Readable Attributes.
> > > + */
> > > +struct cxl_scrub_rd_attrbs {
> > > +	u8 scrub_cycle_cap;
> > > +	__le16 scrub_cycle_hours;
> > > +	u8 scrub_flags;
> > > +} __packed;
> > > +
> > > +/*
> > > + * See CXL spec rev 3.2 @8.2.10.9.11.1 Table 8-223 Device Patrol Scrub Control
> > > + * Feature Writable Attributes.
> > > + */
> > > +struct cxl_scrub_wr_attrbs {
> > > +	u8 scrub_cycle_hours;
> > > +	u8 scrub_flags;
> > > +} __packed;
> > > +
> > > +#define CXL_SCRUB_CONTROL_CHANGEABLE BIT(0)
> > > +#define CXL_SCRUB_CONTROL_REALTIME BIT(1)
> > > +#define CXL_SCRUB_CONTROL_CYCLE_MASK GENMASK(7, 0)
> > > +#define CXL_SCRUB_CONTROL_MIN_CYCLE_MASK GENMASK(15, 8)
> > > +#define CXL_SCRUB_CONTROL_ENABLE BIT(0)
> > > +
> > > +#define CXL_GET_SCRUB_CYCLE_CHANGEABLE(cap) \
> > > +	FIELD_GET(CXL_SCRUB_CONTROL_CHANGEABLE, cap)
> > > +#define CXL_GET_SCRUB_CYCLE(cycle) \
> > > +	FIELD_GET(CXL_SCRUB_CONTROL_CYCLE_MASK, cycle)
> > > +#define CXL_GET_SCRUB_MIN_CYCLE(cycle) \
> > > +	FIELD_GET(CXL_SCRUB_CONTROL_MIN_CYCLE_MASK, cycle)
> > > +#define CXL_GET_SCRUB_EN_STS(flags) FIELD_GET(CXL_SCRUB_CONTROL_ENABLE, flags)
> > > +
> > > +#define CXL_SET_SCRUB_CYCLE(cycle) \
> > > +	FIELD_PREP(CXL_SCRUB_CONTROL_CYCLE_MASK, cycle)
> > > +#define CXL_SET_SCRUB_EN(en) FIELD_PREP(CXL_SCRUB_CONTROL_ENABLE, en)
> > > +
> > > +static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
> > > +				    u16 *cycle, u8 *flags, u8 *min_cycle)
> > > +{
> > > +	size_t rd_data_size = sizeof(struct cxl_scrub_rd_attrbs);
> > > +	size_t data_size;
> > > +	struct cxl_scrub_rd_attrbs *rd_attrbs __free(kfree) =
> > > +		kzalloc(rd_data_size, GFP_KERNEL);
> > > +	if (!rd_attrbs)
> > > +		return -ENOMEM;
> > > +
> > > +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> > > +				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
> > > +				    rd_data_size, 0, NULL);
> > > +	if (!data_size)
> > > +		return -EIO;
> > > +
> > > +	*cap = rd_attrbs->scrub_cycle_cap;
> > > +	*cycle = le16_to_cpu(rd_attrbs->scrub_cycle_hours);
> > > +	*flags = rd_attrbs->scrub_flags;
> > > +	if (min_cycle)
> > > +		*min_cycle = CXL_GET_SCRUB_MIN_CYCLE(*cycle);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> > > +				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
> > > +{
> > > +	struct cxl_mailbox *cxl_mbox;
> > > +	u8 min_scrub_cycle = U8_MAX;
> > > +	struct cxl_region_params *p;
> > > +	struct cxl_memdev *cxlmd;
> > > +	struct cxl_region *cxlr;
> > > +	int i, ret;
> > > +
> > > +	if (!cxl_ps_ctx->cxlr) {
> > > +		cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> > > +		return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> > > +						flags, min_cycle);
> > > +	}
> > > +
> > > +	struct rw_semaphore *region_lock __free(rwsem_read_release) =
> > > +	rwsem_read_intr_acquire(&cxl_region_rwsem);
> > > +	if (!region_lock)
> > > +		return -EINTR;
> > > +
> > > +	cxlr = cxl_ps_ctx->cxlr;
> > > +	p = &cxlr->params;
> > > +
> > > +	for (i = 0; i < p->nr_targets; i++) {
> > > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > > +
> > > +		cxlmd = cxled_to_memdev(cxled);
> > > +		cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> > > +		ret = cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> > > +					       flags, min_cycle);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		if (min_cycle)
> > > +			min_scrub_cycle =
> > > +				min(*min_cycle, min_scrub_cycle);
> > > +	}
> > > +
> > > +	if (min_cycle)
> > > +		*min_cycle = min_scrub_cycle;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_scrub_set_attrbs_region(struct device *dev,
> > > +				       struct cxl_patrol_scrub_context *cxl_ps_ctx,
> > > +				       u8 cycle, u8 flags)
> > > +{
> > > +	struct cxl_scrub_wr_attrbs wr_attrbs;
> > > +	struct cxl_mailbox *cxl_mbox;
> > > +	struct cxl_region_params *p;
> > > +	struct cxl_memdev *cxlmd;
> > > +	struct cxl_region *cxlr;
> > > +	int ret, i;
> > > +
> > > +	struct rw_semaphore *region_lock __free(rwsem_read_release) =
> > > +		rwsem_read_intr_acquire(&cxl_region_rwsem);
> > > +	if (!region_lock)
> > > +		return -EINTR;
> > > +
> > > +	cxlr = cxl_ps_ctx->cxlr;
> > > +	p = &cxlr->params;
> > > +	wr_attrbs.scrub_cycle_hours = cycle;
> > > +	wr_attrbs.scrub_flags = flags;
> > > +
> > > +	for (i = 0; i < p->nr_targets; i++) {
> > > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > > +
> > > +		cxlmd = cxled_to_memdev(cxled);
> > > +		cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> > > +		ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> > > +				      cxl_ps_ctx->set_version, &wr_attrbs,
> > > +				      sizeof(wr_attrbs),
> > > +				      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> > > +				      0, NULL);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		if (cycle != cxlmd->scrub_cycle) {
> > > +			if (cxlmd->scrub_region_id != CXL_SCRUB_NO_REGION)
> > > +				dev_info(dev,
> > > +					 "Device scrub rate(%d hours) set by region%d rate overwritten by region%d scrub rate(%d hours)\n",
> > > +					 cxlmd->scrub_cycle,
> > > +					 cxlmd->scrub_region_id, cxlr->id,
> > > +					 cycle);
> > > +
> > > +			cxlmd->scrub_cycle = cycle;
> > > +			cxlmd->scrub_region_id = cxlr->id;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_scrub_set_attrbs_device(struct device *dev,
> > > +				       struct cxl_patrol_scrub_context *cxl_ps_ctx,
> > > +				       u8 cycle, u8 flags)
> > > +{
> > > +	struct cxl_scrub_wr_attrbs wr_attrbs;
> > > +	struct cxl_mailbox *cxl_mbox;
> > > +	struct cxl_memdev *cxlmd;
> > > +	int ret;
> > > +
> > > +	wr_attrbs.scrub_cycle_hours = cycle;
> > > +	wr_attrbs.scrub_flags = flags;
> > > +
> > > +	cxlmd = cxl_ps_ctx->cxlmd;
> > > +	cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> > > +	ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> > > +			      cxl_ps_ctx->set_version, &wr_attrbs,
> > > +			      sizeof(wr_attrbs),
> > > +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET, 0,
> > > +			      NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (cycle != cxlmd->scrub_cycle) {
> > > +		if (cxlmd->scrub_region_id != CXL_SCRUB_NO_REGION)
> > > +			dev_info(dev,
> > > +				 "Device scrub rate(%d hours) set by region%d rate overwritten with device local scrub rate(%d hours)\n",
> > > +				 cxlmd->scrub_cycle, cxlmd->scrub_region_id,
> > > +				 cycle);
> > > +
> > > +		cxlmd->scrub_cycle = cycle;
> > > +		cxlmd->scrub_region_id = CXL_SCRUB_NO_REGION;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_scrub_set_attrbs(struct device *dev,
> > > +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
> > > +				u8 cycle, u8 flags)
> > > +{
> > > +	if (cxl_ps_ctx->cxlr)
> > > +		return cxl_scrub_set_attrbs_region(dev, cxl_ps_ctx, cycle, flags);
> > > +
> > > +	return cxl_scrub_set_attrbs_device(dev, cxl_ps_ctx, cycle, flags);
> > > +}
> > > +
> > > +static int cxl_patrol_scrub_get_enabled_bg(struct device *dev, void *drv_data,
> > > +					   bool *enabled)
> > > +{
> > > +	struct cxl_patrol_scrub_context *ctx = drv_data;
> > > +	u8 cap, flags;
> > > +	u16 cycle;
> > > +	int ret;
> > > +
> > > +	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*enabled = CXL_GET_SCRUB_EN_STS(flags);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_patrol_scrub_set_enabled_bg(struct device *dev, void *drv_data,
> > > +					   bool enable)
> > > +{
> > > +	struct cxl_patrol_scrub_context *ctx = drv_data;
> > > +	u8 cap, flags, wr_cycle;
> > > +	u16 rd_cycle;
> > > +	int ret;
> > > +
> > > +	if (!capable(CAP_SYS_RAWIO))
> > > +		return -EPERM;
> > > +
> > > +	ret = cxl_scrub_get_attrbs(ctx, &cap, &rd_cycle, &flags, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	wr_cycle = CXL_GET_SCRUB_CYCLE(rd_cycle);
> > > +	flags = CXL_SET_SCRUB_EN(enable);
> > > +
> > > +	return cxl_scrub_set_attrbs(dev, ctx, wr_cycle, flags);
> > > +}
> > > +
> > > +static int cxl_patrol_scrub_get_min_scrub_cycle(struct device *dev,
> > > +						void *drv_data, u32 *min)
> > > +{
> > > +	struct cxl_patrol_scrub_context *ctx = drv_data;
> > > +	u8 cap, flags, min_cycle;
> > > +	u16 cycle;
> > > +	int ret;
> > > +
> > > +	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, &min_cycle);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*min = min_cycle * 3600;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_patrol_scrub_get_max_scrub_cycle(struct device *dev,
> > > +						void *drv_data, u32 *max)
> > > +{
> > > +	*max = U8_MAX * 3600; /* Max set by register size */
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_patrol_scrub_get_scrub_cycle(struct device *dev, void *drv_data,
> > > +					    u32 *scrub_cycle_secs)
> > > +{
> > > +	struct cxl_patrol_scrub_context *ctx = drv_data;
> > > +	u8 cap, flags;
> > > +	u16 cycle;
> > > +	int ret;
> > > +
> > > +	ret = cxl_scrub_get_attrbs(ctx, &cap, &cycle, &flags, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*scrub_cycle_secs = CXL_GET_SCRUB_CYCLE(cycle) * 3600;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_patrol_scrub_set_scrub_cycle(struct device *dev, void *drv_data,
> > > +					    u32 scrub_cycle_secs)
> > > +{
> > > +	struct cxl_patrol_scrub_context *ctx = drv_data;
> > > +	u8 scrub_cycle_hours = scrub_cycle_secs / 3600;
> > > +	u8 cap, wr_cycle, flags, min_cycle;
> > > +	u16 rd_cycle;
> > > +	int ret;
> > > +
> > > +	if (!capable(CAP_SYS_RAWIO))
> > > +		return -EPERM;
> > > +
> > > +	ret = cxl_scrub_get_attrbs(ctx, &cap, &rd_cycle, &flags, &min_cycle);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (!CXL_GET_SCRUB_CYCLE_CHANGEABLE(cap))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (scrub_cycle_hours < min_cycle) {
> > > +		dev_dbg(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> > > +			scrub_cycle_hours);
> > > +		dev_dbg(dev,
> > > +			"Minimum supported CXL patrol scrub cycle in hour %d\n",
> > > +			min_cycle);
> > > +		return -EINVAL;
> > > +	}
> > > +	wr_cycle = CXL_SET_SCRUB_CYCLE(scrub_cycle_hours);
> > > +
> > > +	return cxl_scrub_set_attrbs(dev, ctx, wr_cycle, flags);
> > > +}
> > > +
> > > +static const struct edac_scrub_ops cxl_ps_scrub_ops = {
> > > +	.get_enabled_bg = cxl_patrol_scrub_get_enabled_bg,
> > > +	.set_enabled_bg = cxl_patrol_scrub_set_enabled_bg,
> > > +	.get_min_cycle = cxl_patrol_scrub_get_min_scrub_cycle,
> > > +	.get_max_cycle = cxl_patrol_scrub_get_max_scrub_cycle,
> > > +	.get_cycle_duration = cxl_patrol_scrub_get_scrub_cycle,
> > > +	.set_cycle_duration = cxl_patrol_scrub_set_scrub_cycle,
> > > +};
> > > +
> > > +static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd,
> > > +				 struct edac_dev_feature *ras_feature,
> > > +				 u8 scrub_inst)
> > > +{
> > > +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> > > +	struct cxl_feat_entry *feat_entry;
> > > +	u8 cap, flags;
> > > +	u16 cycle;
> > > +	int rc;
> > > +
> > > +	feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
> > > +				      &CXL_FEAT_PATROL_SCRUB_UUID);
> > > +	if (IS_ERR(feat_entry))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> > > +	if (!cxl_ps_ctx)
> > > +		return -ENOMEM;
> > > +
> > > +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context){
> > > +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> > > +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> > > +		.get_version = feat_entry->get_feat_ver,
> > > +		.set_version = feat_entry->set_feat_ver,
> > > +		.effects = le16_to_cpu(feat_entry->effects),
> > > +		.instance = scrub_inst,
> > > +		.cxlmd = cxlmd,
> > > +	};
> > > +
> > > +	rc = cxl_mem_scrub_get_attrbs(&cxlmd->cxlds->cxl_mbox, &cap, &cycle,
> > > +				      &flags, NULL);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	cxlmd->scrub_cycle = CXL_GET_SCRUB_CYCLE(cycle);
> > > +	cxlmd->scrub_region_id = CXL_SCRUB_NO_REGION;
> > > +
> > > +	ras_feature->ft_type = RAS_FEAT_SCRUB;
> > > +	ras_feature->instance = cxl_ps_ctx->instance;
> > > +	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
> > > +	ras_feature->ctx = cxl_ps_ctx;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cxl_region_scrub_init(struct cxl_region *cxlr,
> > > +				 struct edac_dev_feature *ras_feature,
> > > +				 u8 scrub_inst)
> > > +{
> > > +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> > > +	struct cxl_region_params *p = &cxlr->params;
> > > +	struct cxl_feat_entry *feat_entry = NULL;
> > > +	struct cxl_memdev *cxlmd;
> > > +	u8 cap, flags;
> > > +	u16 cycle;
> > > +	int i, rc;
> > > +
> > > +	/*
> > > +	 * The cxl_region_rwsem must be held if the code below is used in a context
> > > +	 * other than when the region is in the probe state, as shown here.
> > > +	 */
> > > +	for (i = 0; i < p->nr_targets; i++) {
> > > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > > +
> > > +		cxlmd = cxled_to_memdev(cxled);
> > > +		feat_entry = cxl_feature_info(to_cxlfs(cxlmd->cxlds),
> > > +					      &CXL_FEAT_PATROL_SCRUB_UUID);
> > > +		if (IS_ERR(feat_entry))
> > > +			return -EOPNOTSUPP;
> > > +
> > > +		if (!(le32_to_cpu(feat_entry->flags) &
> > > +		      CXL_FEATURE_F_CHANGEABLE))
> > > +			return -EOPNOTSUPP;
> > > +
> > > +		rc = cxl_mem_scrub_get_attrbs(&cxlmd->cxlds->cxl_mbox, &cap,
> > > +					      &cycle, &flags, NULL);
> > > +		if (rc)
> > > +			return rc;
> > > +
> > > +		cxlmd->scrub_cycle = CXL_GET_SCRUB_CYCLE(cycle);
> > > +		cxlmd->scrub_region_id = CXL_SCRUB_NO_REGION;
> > > +	}
> > > +
> > > +	cxl_ps_ctx = devm_kzalloc(&cxlr->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> > > +	if (!cxl_ps_ctx)
> > > +		return -ENOMEM;
> > > +
> > > +	*cxl_ps_ctx = (struct cxl_patrol_scrub_context){
> > > +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> > > +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> > > +		.get_version = feat_entry->get_feat_ver,
> > > +		.set_version = feat_entry->set_feat_ver,
> > > +		.effects = le16_to_cpu(feat_entry->effects),
> > > +		.instance = scrub_inst,
> > > +		.cxlr = cxlr,
> > > +	};
> > > +
> > > +	ras_feature->ft_type = RAS_FEAT_SCRUB;
> > > +	ras_feature->instance = cxl_ps_ctx->instance;
> > > +	ras_feature->scrub_ops = &cxl_ps_scrub_ops;
> > > +	ras_feature->ctx = cxl_ps_ctx;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
> > > +{
> > > +	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
> > > +	int num_ras_features = 0;
> > > +	int rc;
> > > +
> > > +	if (IS_ENABLED(CONFIG_CXL_EDAC_SCRUB)) {
> > > +		rc = cxl_memdev_scrub_init(cxlmd, &ras_features[num_ras_features], 0);
> > > +		if (rc < 0 && rc != -EOPNOTSUPP)
> > > +			return rc;
> > > +
> > > +		if (rc != -EOPNOTSUPP)
> > > +			num_ras_features++;
> > > +	}
> > > +
> > > +	if (!num_ras_features)
> > > +		return -EINVAL;
> > > +
> > > +	char *cxl_dev_name __free(kfree) =
> > > +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlmd->dev));
> > > +	if (!cxl_dev_name)
> > > +		return -ENOMEM;
> > > +
> > > +	return edac_dev_register(&cxlmd->dev, cxl_dev_name, NULL,
> > > +				 num_ras_features, ras_features);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_register, "CXL");
> > > +
> > > +int devm_cxl_region_edac_register(struct cxl_region *cxlr)
> > > +{
> > > +	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
> > > +	int num_ras_features = 0;
> > > +	int rc;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_CXL_EDAC_SCRUB))
> > > +		return 0;
> > > +
> > > +	rc = cxl_region_scrub_init(cxlr, &ras_features[num_ras_features], 0);
> > > +	if (rc < 0)
> > > +		return rc;
> > > +
> > > +	num_ras_features++;
> > > +
> > > +	char *cxl_dev_name __free(kfree) =
> > > +		kasprintf(GFP_KERNEL, "cxl_%s", dev_name(&cxlr->dev));
> > > +	if (!cxl_dev_name)
> > > +		return -ENOMEM;
> > > +
> > > +	return edac_dev_register(&cxlr->dev, cxl_dev_name, NULL,
> > > +				 num_ras_features, ras_features);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index c3f4dc244df7..d5b8108c4a6d 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -3537,8 +3537,18 @@ static int cxl_region_probe(struct device *dev)
> > >  
> > >  	switch (cxlr->mode) {
> > >  	case CXL_PARTMODE_PMEM:
> > > +		rc = devm_cxl_region_edac_register(cxlr);
> > > +		if (rc)
> > > +			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> > > +				cxlr->id);
> > > +
> > >  		return devm_cxl_add_pmem_region(cxlr);
> > >  	case CXL_PARTMODE_RAM:
> > > +		rc = devm_cxl_region_edac_register(cxlr);
> > > +		if (rc)
> > > +			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> > > +				cxlr->id);
> > > +
> > >  		/*
> > >  		 * The region can not be manged by CXL if any portion of
> > >  		 * it is already online as 'System RAM'
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index a9ab46eb0610..8a252f8483f7 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -912,4 +912,14 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> > >  
> > >  u16 cxl_gpf_get_dvsec(struct device *dev);
> > >  
> > > +static inline struct rw_semaphore *rwsem_read_intr_acquire(struct rw_semaphore *rwsem)
> > > +{
> > > +	if (down_read_interruptible(rwsem))
> > > +		return NULL;
> > > +
> > > +	return rwsem;
> > > +}
> > > +
> > > +DEFINE_FREE(rwsem_read_release, struct rw_semaphore *, if (_T) up_read(_T))
> > > +
> > >  #endif /* __CXL_H__ */
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 3ec6b906371b..872131009e4c 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -45,6 +45,8 @@
> > >   * @endpoint: connection to the CXL port topology for this memory device
> > >   * @id: id number of this memdev instance.
> > >   * @depth: endpoint port depth
> > > + * @scrub_cycle: current scrub cycle set for this device
> > > + * @scrub_region_id: id number of a backed region (if any) for which current scrub cycle set
> > >   */
> > >  struct cxl_memdev {
> > >  	struct device dev;
> > > @@ -56,6 +58,8 @@ struct cxl_memdev {
> > >  	struct cxl_port *endpoint;
> > >  	int id;
> > >  	int depth;
> > > +	u8 scrub_cycle;
> > > +	int scrub_region_id;
> > >  };
> > >  
> > >  static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
> > > @@ -853,6 +857,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
> > >  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
> > >  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> > >  
> > > +#ifdef CONFIG_CXL_EDAC_MEM_FEATURES
> > > +int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
> > > +int devm_cxl_region_edac_register(struct cxl_region *cxlr);
> > > +#else
> > > +static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
> > > +{ return 0; }
> > > +static inline int devm_cxl_region_edac_register(struct cxl_region *cxlr)
> > > +{ return 0; }
> > > +#endif
> > > +
> > >  #ifdef CONFIG_CXL_SUSPEND
> > >  void cxl_mem_active_inc(void);
> > >  void cxl_mem_active_dec(void);
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index 9675243bd05b..6e6777b7bafb 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -180,6 +180,10 @@ static int cxl_mem_probe(struct device *dev)
> > >  			return rc;
> > >  	}
> > >  
> > > +	rc = devm_cxl_memdev_edac_register(cxlmd);
> > > +	if (rc)
> > > +		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
> > > +
> > >  	/*
> > >  	 * The kernel may be operating out of CXL memory on this device,
> > >  	 * there is no spec defined way to determine whether this device
> > > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > > index 387f3df8b988..31a2d73c963f 100644
> > > --- a/tools/testing/cxl/Kbuild
> > > +++ b/tools/testing/cxl/Kbuild
> > > @@ -67,6 +67,7 @@ cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> > >  cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
> > >  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
> > >  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
> > > +cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
> > >  cxl_core-y += config_check.o
> > >  cxl_core-y += cxl_core_test.o
> > >  cxl_core-y += cxl_core_exports.o
> > > -- 
> > > 2.43.0
> > >   
> > 
> 
> 

