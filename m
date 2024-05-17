Return-Path: <linux-edac+bounces-1074-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF68C8DD7
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 23:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354C31F23B9E
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2024 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126E1411DD;
	Fri, 17 May 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dochnruL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421239FFD;
	Fri, 17 May 2024 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982198; cv=fail; b=n1xClzmBJcxgT3wrwti2tJNtJjbbfOeE6bj0aDqr3JqhWlO+rkkq8PZ1q44IW7C6ww9aR+0BTy70KKyOxCmoPxABIOZ0Fx1Y5DSUKFXRtfhwfSax8nmDl7UMfu/JhX9Upvgqm6aIz9X5rmSbqgzLOIpMAy6PRMabSM/2IvTcvX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982198; c=relaxed/simple;
	bh=TM4/kpSaz8vaxZmAg79cZXDRJ8aG10OQgEujdf8p++g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L1nKSt2auv0+Wyvhjts8D1brTCqHUjucwfFqUBvqXIaR5rB8WRiAVv3X/NJfgzYpOqcKleUOmMflh9h41TaRafaDFB9IApukJT9Ve8916jGHAS5eAGwbqUYZyg/wC2kA8VIf1nM0CnwJiBKFPsTAT9fRebpdaMcdnr3MFNPbQfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dochnruL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715982198; x=1747518198;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TM4/kpSaz8vaxZmAg79cZXDRJ8aG10OQgEujdf8p++g=;
  b=dochnruLH9hoZDV32FB+msmN0pbp69ZDgMOQiX+ah8CKsI9ds/SDQ6vt
   N0gekSggozLm61g1Cl5caTgEn1qZzMqpQc7Na44OOz4ZbnrA9eiSrDfQa
   TzIVDzn9ymJ5t2EtxaSqA7s1VJiguUC0/o7CiSSXbnIO+X7JicRep/yHa
   gYmeMepLMOkTS0Ogq0IMRD5tugO6+IloW9zlzDpa+XKDugRoEBdgn8T9g
   IQIutEIXUM/kjOT4CLo9qwDCK0JLyaIk7RSnBefDVdR/m4VU7jjeI7tLE
   s1z5SRXKbgL4Mu2qyW0QWDmGEeTZ+0Ujq0Mlk1XL8Bw0kLmuqa0AWhxnS
   g==;
X-CSE-ConnectionGUID: 6vM+Zaf1S+GKkb+Mg8DaUA==
X-CSE-MsgGUID: FoDp24s0RyW6E2JxHGlOow==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12293824"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12293824"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 14:43:17 -0700
X-CSE-ConnectionGUID: TjYJXruGTnOypCNwZBI0VA==
X-CSE-MsgGUID: t6BfKVptTRCudpBhLBsD5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="32483601"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 14:43:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 14:43:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 14:43:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 14:43:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 14:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jajf7cVesccmk1nS7Plec9TBO5C38yNMEj1lWNr1xa0dlb8PVMUK+DSKuwx584/V5rnA6w0pEsVR1R/H828njgo4yDRlW3OYDZoCw2vpbFOY3lAxP8pa7RpAYLKkls8CsczRdGOaLAjgt9GIbmTpGswqxWp4ggWjZA5m5UjXelbJOi4AkPKyIMZrQ8dhtXtN1/t+S76T504dJfmlGn7TJnrirEHrLd6IdHKmilAnhiRu19krncwiyD9Q85AIDTUzysp2tNexnGIo6uzzi1T+g7r+Sj100zUHtmHwY9Hi2o9w7exHBDQbqUL2pv8Blgb/qB+jf0wnHSwHbGTDQNcBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/axXNfPF0FqIIFevgSWsToLhIjnPBHIrPQ4UXf/h+7U=;
 b=izC9+Ththodm3JbrmTBbzMy4BQzthcbWtBoMGYTXgYRLZrGoSb6FQoqyYEhib4FHuKxBGdsVZJCKCuv6kMm1YsTwUmvZbY3nPSZTeNgsWR0L6M1rQLhKzYAssmauxCw7h6nvL577Rqbr/gOnKSpFz6PP8hC6RG1kuVOleBUsJz9cI2gcItav9sPQdvTVjTuH/YC48aLs9hsWGeA4i7rzeKnTXjLF5rqBOAL9fXqKQJdoqdhv7GUqZay2dGMwK0QMneDQSQ+QdWTxNlkoefkEEqCWqUMV9gMZKpeaBck+fbQE3lqjc1RTWWM+pKdGErxO+vSPBTPAipx3EYmAH4TrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7561.namprd11.prod.outlook.com (2603:10b6:510:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 21:43:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 21:43:13 +0000
Date: Fri, 17 May 2024 14:43:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <6647cf6f55112_2c2629436@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
 <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
 <20240511130801.GBZj9tsenZ5SKXgRTm@fat_crate.local>
 <6641548474088_3dce92942b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240516095714.GCZkXYeiKbUk2QXoIO@fat_crate.local>
 <664656cf7c59b_2c2629493@dwillia2-xfh.jf.intel.com.notmuch>
 <SJ1PR11MB608345327C015187C13A23D3FCED2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608345327C015187C13A23D3FCED2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: f8522008-1ebb-402d-c382-08dc76ba5a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NGH3LCy0Lp5UM2EdtIjJ/VWmMnj+fmRzHT/fS4S8NooXJfiLndwYKjQKtwOb?=
 =?us-ascii?Q?DW/k8vDoHuDK6ZZCySZyDsBdXZ8cq+NMlTzSDq1clTiIQsvWg6Td/fGNA96d?=
 =?us-ascii?Q?epQkSJ4yrnseI/rBR15rLYkqblNJIGk06+C1ltR9erPczmguUuJGm6IFpSj/?=
 =?us-ascii?Q?qV/g6sZWKFIWjZgNEM23CyGwOPrwmWLaXYYPcEL9P+uiDJr2K38YNcNrmy95?=
 =?us-ascii?Q?VYPmGrhqoAfhPvqkX4BZwiyYY/+0bPvKlPdR0qVcZ2vXBrJfTvkBiBNbu58a?=
 =?us-ascii?Q?KPCfCe6yUd12X2kna1kNVOqFh1FRfdZoVqv0GIRxKeMgZkzy0Or/dayxIzHj?=
 =?us-ascii?Q?x02b4IhppnUTDvocwvZ9BbVQ12wPMkyhXgNFfyJYM784ytFOMHoed5PQaeuc?=
 =?us-ascii?Q?6oAG4g88Y0zeobVgvjQFLDaiQapnWEH3HLeVl5VFIRMVH48mNEKTS5aYpa5k?=
 =?us-ascii?Q?x+GUgnNHYABp3ok1WlGKDbBoKzl5D/gLGh3TOd1hO6Jq5St+KtK6TU3DMHxj?=
 =?us-ascii?Q?dPIRem008mZVFCpW9BrsXrqXt0oOmH0/5SsfrkVA9GH3TTiGkxE4hk70+yTJ?=
 =?us-ascii?Q?AwZuf1bk0i0MoJPpZXLrvqSPf4kNUK8Rocb6M7z7wkP5Aibd0iI+DvsXirK+?=
 =?us-ascii?Q?amYgyvQ5RAvJizoaA/rAtSpT4xdUC/SJrm7aS10Dg8kKTq4VQlzQl+gMjALs?=
 =?us-ascii?Q?BV9xtYvO3fCi1DiBv9SYkFC0cwEh5yfoVe7Gi48CudkWe8fIU0uKzL5XCaIC?=
 =?us-ascii?Q?8BNnFGdgvtV2DvY0/BDZAyyPRlY3IA3Kwy0cYKOKKB/2pzKPDrrw/FwReJEj?=
 =?us-ascii?Q?Qn/HSSuWGEna77rajwnJ7oqu48UWljP1FveEde8yrMxExeBc/OmbgMwti7dW?=
 =?us-ascii?Q?TbTWJZcCbK7TOw0ULqcU2PkIyx47NZC8Pv4Z4Dh3T+8lasQJ/uKEXjhQ35LE?=
 =?us-ascii?Q?Wbp45GUQolLebLdP0Xe9sD5ddJzpOybsEPtmnLzjjq6s8JO6xnqMd8ECoxC6?=
 =?us-ascii?Q?5zR5KpqX4+2HF1EM5zNskIBP0nqb0qd6vWJSjvPMKI2LLHtwn5t3KrEBk0Q0?=
 =?us-ascii?Q?0yr9D8sgbz6izSmCLBb7E5KOiUjEZ3JKiTxegXFRs0BkbTvI7eyAwBa7S+3C?=
 =?us-ascii?Q?v8vhqNyve6YBlI1CgQEkozr7UD6nZoGm3LUjhGhNQr+55blAbKNkAXvc50/o?=
 =?us-ascii?Q?Mzcn64sYpf9TF4nQscTt81vso1TG1nahEpeHnPJ3VlT9Rho3Da9O+GY/We9s?=
 =?us-ascii?Q?C/3oyM0/6yX+PdOWt0qjR+OjXkSwI73pr+UNtMD0rQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vU+ufX6TK6SW3KUQyNWD/fYrpm9BsiLcHK3Y2L4Lht5CyvtQN8YVKNY/Zn7j?=
 =?us-ascii?Q?W+7/fdyr6efhavkBzWb0NmZZcvjzgCCImiKLfIpI1R/as8Y4X0ptVTm0qaTX?=
 =?us-ascii?Q?Bq/QxT1TbSwtJSDNmASHj2T7AoyJITsuKMQnS/mYUabKoWyvKi7/UdfK4js8?=
 =?us-ascii?Q?xtPHw0xtp56YNlIwtpovOiusulZ1l4pmc0F0EeUZOfOl76Lsntyq2w6pU4so?=
 =?us-ascii?Q?Amhkg3Sv7F7eMuek7zYN0p9kL8mRt8pIkJdHizxEATlYpqnkntL8Q58KhLF5?=
 =?us-ascii?Q?dSqaSSwxxtX2ZPQWRGGfXivQgzsOirOt8n/n3cc4HW5BhS8ZO/Mx3RPsKIX3?=
 =?us-ascii?Q?6DHZImIwCh8aEbUqtOPnv5wrr/wblO9XZOEQJe2nvALONNNgYDg6T2a4iI7D?=
 =?us-ascii?Q?drAbyT4hZ4dkmsImUu3h15D2oWwSfhFsktanMxqyHzb/zlmLkVIjhKb/s+SX?=
 =?us-ascii?Q?p9Fe+CKiYj6BJtDtNVyIIM4fF2aGTbD6Wm0o2bkloj8O8zG3qvwBTw5W2a6h?=
 =?us-ascii?Q?kMwRa+r3nhlMZfd+TQr1YdfchIrrf3oUTrLnLLpaH2TDHPA/tTn7C4EQgN8C?=
 =?us-ascii?Q?BHMol+9V4Va+ksMJuPoAuyl29ryreQC1YUEOGZMTNlNBzodfHKZyz0wC60Hd?=
 =?us-ascii?Q?1n/RaI6DwvWd3O2xYqtkfbbwqum2MhNvNBBcaRzs0CsV1pPGgDxGSmKXhpMj?=
 =?us-ascii?Q?QyGHZrZZftdaaUpm+04oVTpJ+/q3DB2r5Ch+4qLcXR8t+itZY0+kff4Uopmb?=
 =?us-ascii?Q?vH9Is/7fars/YkJxvLKVW7nZWhdFEx4wP0Kx89dcJ9FvyMZIXWjrfmqqsWSP?=
 =?us-ascii?Q?b6dqvWQ/BRpxImSolWuC0OKgewCucjQlIGoDUh7r9S7rT8CniBt7UizInXFe?=
 =?us-ascii?Q?Q23fskrbsqDsQ3Z8PWE8BOk/0ixOXbsIYqI7cBjrnxRiH560sNOwBECjmrIL?=
 =?us-ascii?Q?/vawn3KBOzFroXiZ8r2/hcF1ZuIi2r6Mopr+DLY9jHvSPm6pk9XY2dLsbOT5?=
 =?us-ascii?Q?rhFTLnLsi8eIRwJNduBhRw3lOL4nw+/8FNKoOdBKS5v43qzi5K5t1R44hYcm?=
 =?us-ascii?Q?4SxPz2yvHST0J9IvyqvVmP+vWf86wyGObrTrVbrV1crZIxtw+bcBbiMlgWdr?=
 =?us-ascii?Q?U+dvaZQrGxyMQU3ulY7Q3hJ5l4hqlcsPy1EM7nBQETlJbG48abFzKTqdnSdk?=
 =?us-ascii?Q?zhpymmHwn2n1TyNsqWhL40jkrd1IniPtZotc4yGlkuZKdnfrlut4S5yW627v?=
 =?us-ascii?Q?fe85Xz+1MmqYaS7g1qnQW32odHYaRl3qb058TuDhZa5EynVTASJzu14rPbSs?=
 =?us-ascii?Q?mWqk4SvsZ1suSOJnNVV2G0Ecp63LcsZLyOR3mgIcW/o5BJIhc3Tn1ju8jQXx?=
 =?us-ascii?Q?+G+iRbBXC8ndvFvNhZB4X5SjS+S5+bH1V4L0sBxlplVav0hlu7qGT/lMgum4?=
 =?us-ascii?Q?jafDQvGXWXaJ3NUj+xW/wyvxvuw0ZAHXXxPWWfO0Iu4CiopxjzRNqb2naqL3?=
 =?us-ascii?Q?65Il885WdNhDA+fH4ZMJm6W2SK4NVcAMmPaITqCJj4ycB8igsOGTKbUyZuYy?=
 =?us-ascii?Q?d+EWS16CYGzbAfs21qYRRv2s9NdjgfAtpzROAHH5vWh8hbTjS9v+UTfegKvn?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8522008-1ebb-402d-c382-08dc76ba5a8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 21:43:13.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvXctHXKhOxQQ82SY0bdl8xJHSuhPiy0NsX92v5yH4E9ssoUdD7z32OZCzKtyCeyDldrL06utyblflGrN5od7reDCLavr4TpdOD+BD0gDiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7561
X-OriginatorOrg: intel.com

Luck, Tony wrote:
> > Given that is has not kept pace the next question is whether the kernel
> > should bother to maintain the contract => "if nothing is watching
> > tracepoints some subset (all?) hardware error messages will be reflected
> > to the kernel log".
> 
> I'm with you for corrected & recoverable errors. The console is a terrible
> place for those logs.
> 
> But it's handy to have fatal errors go to the console. They may make it out to a
> serial port, or be stashed in pstore for later retrieval. Trace event logs that
> are handled by some user level daemon are just going to disappear in a
> puff of reset smoke.

That is true, and arguably that fatal event logging to the kernel log should be
independent of whether userspace is watching. I.e. ras_userpsace_consumers()
gating kernel logging is actively getting in the way when the error severity
implies userspace may not get a chance to see or process the event.

I would need help from Steven on whether ftrace would be amenable to have a
localized tracepoint_printk context to trigger emission of fatal events to the
kernel log in addition to the trace buffer.

