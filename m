Return-Path: <linux-edac+bounces-5640-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 902CED1BD13
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 01:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E15653030D8F
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BF214204;
	Wed, 14 Jan 2026 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdUsXxpE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF21E1DEC;
	Wed, 14 Jan 2026 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350621; cv=fail; b=HhVUEShBAA/Cj9VHDbArnYEi+fw2EeiDqlrV/1eEYBTFeQ2WDyCyTQJnnu+Gt+0NN5SFGvwI105P30WO7SepBUVm2SaNULKVyI+n/XnrKK+Z+CwBJyhpM/iKAVLZ7va231U3vtShRcx1tUNHZhdmEevFLVBTYj3JK0NRSnIjcBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350621; c=relaxed/simple;
	bh=4u8BN3DSyK68CwPtvGKoojQ94degvk4oeuNDOTEZMZc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dIxMIRbnvRyFniNbgzXywIfiWqpLUo8ms5KHSLuctHVoxd6/pkBRqmHPZqJH+r/RRFgwjcddl5rDPwwMqhkuuL0pUXgOCehccBnZM7/ItvmbxpVjjNXm9p7CojW+/JaNEOxeqQUqbWwMwooQ4r16nqsAjkoOIAe7IWeKpb1ZfP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdUsXxpE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768350616; x=1799886616;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4u8BN3DSyK68CwPtvGKoojQ94degvk4oeuNDOTEZMZc=;
  b=YdUsXxpEkfl/olb0rOsPmqPYrr6WjmGTI1xQ9zKROCvzj6GDC+XuUlR3
   KIdfAIuS9wnQ9mqpCDZ7lqBPzziJr8DjSv4DTQ887Bddy1ahcixhc9rIp
   5PJhRdvKQZFhplYqTvmeqA3SuiW7aRoo1XbpwTY7PPoDLy5KY3W/woPTY
   Ae4QUTFotjvcly/yE+ESrHoWTxgM8p6s0eqaV0sr0ujexFE6gbxg/PItB
   kNE8Pr8C9UgKKcnftic8HOurJp9SQL7dYjH8zSy9lAYgS7HYW9x651FfC
   hCOBYkf1MuM4zy50EbLoz+nLcE5dWioMS/GzL3kvd+FNWqOzdwugmMSL/
   A==;
X-CSE-ConnectionGUID: E4QECjPRSZy40n8XKNr6KA==
X-CSE-MsgGUID: qDf8AXsZSjibDG42ARTdLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69730387"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69730387"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 16:30:14 -0800
X-CSE-ConnectionGUID: 5VJJ34IST2mGf7X66fcYUA==
X-CSE-MsgGUID: cQ2VjNaoSQ+wS5OiH5iffA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209051664"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 16:30:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 16:30:13 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 16:30:13 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 16:30:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0rLrsktgS5T/8x633LvfgbMYFSL2ftAPyrsEjlXS3sJ/s7uWloUH+F/zNlcHf16dSizE+fJxdz9Ck+yPQjkeCZ1gzW1sGt06blZ7fcUealGivhR58MCiT2g5DgOS61RcRfPco4PcDec8hRFxHw3oSvAfZ6Qmwn4cBTGOoUVUsgihSTFLHs0bfNI+TCxQpBKFfedtx2q8diUeN0efzqirM1zlF8dE+U6yH0MIrCmUx1GTmjyEio6lmgMBAWgM8RuDrIEO4HnTM7/rAbjFXDxhHPcNxM4wlsA/uMBHYJyviJi83TI8aBnQHsdZWnc5dEvrX+pU6qAbXo1kmVbv7as4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cINKd8NdAuDPmb8JuMg2iN3TqkFqbzVL0HBZqCaCNM=;
 b=DiiPcauXaCiaWbE0OlZqaiHEgi4EG8e87CRe1wa52FvUnbqupEQN9224Bc6e3ilrpV6HJa5WzeFAsosjyPVRd6c3oz5Qjp4z41WpBQ1xrHxbxFe8U2Twedmqm85rKNHN7jxXCD5X/8fax2T17s2meFNaHmda+5La9CohBjMJWbvv1uDfY9uoodZXm2E8Y8k+9JsK3m6ASk3VFx6CRZOSiSgJcbxWdAyd4QUDfFGcBZVzlh8SPZEACXzBbU8cCARDkuKu0qMIjRmkHVJOS/W4t2SJCIJG7Pm95ikbM2dKY1nog/BNKq/M3WEnoY0ujmMCKdlMyIVXzDow1RIn+jrfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 00:30:11 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%3]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 00:30:11 +0000
Date: Tue, 13 Jan 2026 16:30:08 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Li, Rongqing" <lirongqing@baidu.com>, Nikolay Borisov
	<nik.borisov@suse.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <aWbjkAPX9a9ZlJGN@agluck-desk3>
References: <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|MN2PR11MB4645:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a60b5d-d54d-44a9-3519-08de530413b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C+UjMbI+N5V9cuVC/7FZ79HiDNK9HpxGYLHEEQKfmBbp/m6bnAsH/zNmYOY9?=
 =?us-ascii?Q?nunaS4z3JCw69Iw0eEDH7wh2M/ufa+QUt9cP0f9anDkJGR9V5j4tJwaFdNIL?=
 =?us-ascii?Q?R4znXQPV6Ge73HnPrntW/JBIXEfa1pkenha97KoSNtCg0C7KgCrv0xFg2Egq?=
 =?us-ascii?Q?LT+24zFo18/21QBg6QF51WrFLuDcb9aVLTN1yXnSUMj6bcmOrSgV7TW42jBp?=
 =?us-ascii?Q?VKkxR0Cc3JbpXYf2gzobe6N3fla1xSNcwszS9LEZSQOToejxeRrtwBenNL5N?=
 =?us-ascii?Q?UWqHghKwnH3p+zJAsFJ8Lc3w1CVBB/COXUlE9V3Az1mDWh5Yd8JKJsUFx0fT?=
 =?us-ascii?Q?Fiaw+EEyXrdnVo9RnudzdJfizPEF/QBHu0rn+N7hpM5WP8ZGp0yw5k5iRBK5?=
 =?us-ascii?Q?yMCseo/snW1hPma0HJfNqCNrESGGhernkCGXrfvpOGn5ekTtwGD5AaXOFG3X?=
 =?us-ascii?Q?t2q5/9V43/z9njz8iX+kSR6/N8+8LqBNKrnZNsYRMTXwL4ywLE4VUv3dfzSo?=
 =?us-ascii?Q?HUU1fwVCK8A7ytzZtBGAEANCHeCuMvrqUFAvv/ACLXbY0HPw3OSy24djMgpt?=
 =?us-ascii?Q?qaLk9IE06+wvB+J7xzDp9hBrNt48EdWdrEtNuFW28wvKMqMIzEaJ5TntfHuw?=
 =?us-ascii?Q?ZnWDPvWa/H3190/Ia3N+CzONxk4O+qQpZiKX32ReSzW0AZhsDnxuorX0I37Q?=
 =?us-ascii?Q?BmQFz3T2J93j3c/VAA6ViQr9UUaDxB49/E77QS0+1SfSr75mcytSv2yIAPdV?=
 =?us-ascii?Q?Dovki4kKEKBe9wK6TzGLu3Br0MFcMES2BhqzeDjCADovne1HS1FXrvfI3q/I?=
 =?us-ascii?Q?tNoABi6tiJKpuvUHLigdeQZWCXt/qZuDfAaldE0SpeO+n5Cjy6gOOx2L+L60?=
 =?us-ascii?Q?ztjS1VG5LDG5IKDsExJGPKZfKZrKd9pn6GepsI7y8hcT/uf+bo6O5lIt3Vzu?=
 =?us-ascii?Q?RgmokKg1oiJboymSug7Mqzb47ibVQCw7z7cxdk+yjxSvmWfcCNgJTZlYsJe8?=
 =?us-ascii?Q?/PuxjeeCW+55LQP/iPUOdExbBe75sLXMA1VIr+5fwEd60wPLzpSr8zdXSUkQ?=
 =?us-ascii?Q?9eTn4jbjPZ/MHjasJyUQ1fpavd8Y2VlAZcxhqgV2x4EW16R4pnTVUN2vJ42R?=
 =?us-ascii?Q?qh4MMrA+VlwdzKtIFUbgimOOHFZG66o1wbHZ4a9e32f8i9ZLXvXDhFj6gBzF?=
 =?us-ascii?Q?8fhUfTSNnYQdCoKw7m9TzF+nzxXtTsR56HExlDpSMPkTnTsEmxiR0QB7oezP?=
 =?us-ascii?Q?xsAlInAWDFtaxQkXQ2QxWOgGl7ct1X6eJf/O84IYty0t0oL4FPVa8Hl5bYnP?=
 =?us-ascii?Q?OPiwaQjpGBULqRjLiBpmQVhjKbFW4U06bVFYXExQ7QrnkQnbr7e34eK9AvTt?=
 =?us-ascii?Q?FphwAOypGLv7OqEeecx3o97exKHnNw8oDNhfPwte/iUT/f3T/QbjGGrsf9Wf?=
 =?us-ascii?Q?hLgUsnci4+j5xz88FfXOCH2J20YRFTqG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kqBdaGNU4IIReOnROCux1O0q0kK9KYklN9pVMSQWF3A+HMNSEudKCsLmKiOa?=
 =?us-ascii?Q?Fc/AXAH5ISX28bG3kF0HgHZuWdKOuxngi/EJin4AGka79XpySHQlIQlr1pNx?=
 =?us-ascii?Q?skFp4eYXJnJ4GigaFI6BJHWlQ31awf79FnWZi0Zz9ss/ookCxATCjBZVPVhE?=
 =?us-ascii?Q?nX85OahE2+tXJdId77IdN+s7CQ+jNG2t1wXM5bqW9zZclyL268xXNJ9ySaR2?=
 =?us-ascii?Q?3kL+n4P/GwSx+GHYXkaabdoLL3XET7imdSNHK1Y1hdd0wuSsouJv6KN85hoG?=
 =?us-ascii?Q?+Y67tNQnYSyM0mUWckKMLmISGfV73Q77gSKsa7AJX+BfvzVZTy0uyg9/Bemq?=
 =?us-ascii?Q?uDjuIkEBMTIq/JZVh5VgiZSZ8anYTqJmDPp+a9107t+Oxv3hddmiCTFJhGKz?=
 =?us-ascii?Q?ele/W4NoTuzwMWgrcqb1H3kM7tYWG0AZxpeb3YhuKTJG+W4D90fSYcIZ3cZp?=
 =?us-ascii?Q?jXQzfM6dLKb9DLF+gIWSBsAitF2UEv6lifPFW6JZK200EQur4VdBno2y/V0H?=
 =?us-ascii?Q?OELYUsuViUnGiZrMnVfuP1kaAQjpA8Z9banNmOU88gbcznqmRtQElZQnCkkS?=
 =?us-ascii?Q?kDeKnP4SbH4c90Hk2sgxNYrS4ulX8SgQdGkh5igCMivBDOeP1Pa38UDIkVUR?=
 =?us-ascii?Q?s2j+1LMbqsyJJk+fJypAihe6+lNEZPRWMe3qsnOcohxCoOyNFV21OlqMIrV9?=
 =?us-ascii?Q?2PUNx3hwzqM7cHFt6rT0pOkO7dzishipbOetD6bOPq7SD6zm41oZkIxjzxCv?=
 =?us-ascii?Q?suzWckPlh7t5fnwPoqGU3ElCUtL3cvrTC7fEFtHEphp5v67KbsqhLrcsBVxO?=
 =?us-ascii?Q?3h5mY6xzfE3BsqAk/zskjKszeVmEEqbhoyvTqdRSwM6eVTvwmJ11cuQTXs3f?=
 =?us-ascii?Q?ea68NTAWNxL2AwVKSwkYVFI/nPKrZlD/4Yw26WWnHEKQ6u2RWyKJDIQqI0+u?=
 =?us-ascii?Q?+E1rhRx9fgJRwfiwqeG+weCdlO2tH+2iqYjkgsOVwM/BrKO4EPUWSNMalTgE?=
 =?us-ascii?Q?lKYrQK01WpstXOkUcRhbleE4puCgJZ1tOVEC6AM3f9rv1/M2B7hWlyEzj7l1?=
 =?us-ascii?Q?8834jGpORpEupZjHqxoWk7Cnxje8yMZvyY2DkUPqnfopyb5rhh6UtaDsY6hB?=
 =?us-ascii?Q?F9Zypw3E1+mQc1v5Qpl6TsIlRFI3qEhuM3uG+NxVlE6SL66gmCiq+Sl1iwvF?=
 =?us-ascii?Q?JxAOTbjUtomIJX6I8vllm+U6zy/npFpXoESrfNTKqhNAmL20sW6nOKDEGWIq?=
 =?us-ascii?Q?TqVeeu3TjFHsCAbsc0oeue+/g0XN4K5Wd9S6jHzR4Mojo9ILje7/pd1Ucw1A?=
 =?us-ascii?Q?lx5+UHto/1x541vU9+MXN/A7PDX4cp5SyhFFqNxAV+oVeQ88LWEzV1dc6JT8?=
 =?us-ascii?Q?2SQ6EWYuidG4UcEBhIWvp63YNIycNfNBvIZZO3DoF2uv2PItBW2m4tR3qHWy?=
 =?us-ascii?Q?s7BaJj412sB48ZR1AmQqyjZWe4Smkaan4i3p+lYPdZknwTiduga3nAlw65mo?=
 =?us-ascii?Q?K4odDQRkBu2gTeqmiUt29Qv7CcOjeEpC15ZgIr4h8VqFU73r44q4IXXALp+e?=
 =?us-ascii?Q?bfZw/zSndy7g1LWkx66cUNRCSF3AxqusGzHhoz1fTe5HS8MzLBCH7upZrCm7?=
 =?us-ascii?Q?2SCrMvo98p2HoFtUQzx362JDOKwxN4pqlqKfu0TXqrr+WNbC633WKljL0/UR?=
 =?us-ascii?Q?IiHYDtCvvemGsnQgJ7XK6CR1GOm4r9WpSW93xcX6kGo6kA6H4hVQFoCLgA30?=
 =?us-ascii?Q?dm2rOzGiAA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a60b5d-d54d-44a9-3519-08de530413b0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 00:30:11.0782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upnMHql3g8GgTNUEIk25M8G3wHZt3FZUcr0xh7p2LWRm0EZF2bG7zstCCa/1HMviKVFrk4oezIYnH3j3LZh24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4645
X-OriginatorOrg: intel.com

On Tue, Jan 13, 2026 at 11:41:52PM +0100, Borislav Petkov wrote:
> On Tue, Jan 13, 2026 at 10:31:58PM +0100, Borislav Petkov wrote:
> > Ufff, how silly and overengineered we've made it. I need to think about
> > a cleaner solution tomorrow...
> 
> One idea I just thought of:
> 
> those two steps:
> 
> 1. setting mce_need_notify, and
> 
> 2.  testing and clearing it
> 
> are basically logically a one query: do we have logged errors, or, IOW, is the
> gen pool not empty?
> 
> IOW, this below.
> 
> That'll get rid of that gunk of when should we test and when set and will
> JustWork(tm) for what we want it to do.
> 
> But let's see how it all really works tomorrow...
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 34440021e8cf..c378d4d450b6 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -595,7 +595,7 @@ static bool mce_notify_irq(void)
>  	/* Not more than two messages every minute */
>  	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
>  
> -	if (test_and_clear_bit(0, &mce_need_notify)) {
> +	if (!mce_gen_pool_empty()) {
>  		mce_work_trigger();
>  
>  		if (__ratelimit(&ratelimit))
> @@ -618,10 +618,6 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
>  	/* Emit the trace record: */
>  	trace_mce_record(err);
>  
> -	set_bit(0, &mce_need_notify);
> -
> -	mce_notify_irq();
> -
>  	return NOTIFY_DONE;
>  }
>  

Seems to work (though you've deleted all the places where mce_need_notify
is used, so you can also delete the declaration.

@@ -90,7 +90,6 @@ struct mca_config mca_cfg __read_mostly = {
 };

 static DEFINE_PER_CPU(struct mce_hw_err, hw_errs_seen);
-static unsigned long mce_need_notify;

 /*
  * MCA banks polled by the period polling timer for corrected events.


I see time delta between logs reducing while I'm injecting errors.

When I pause injection for several minutes, and then restart I see the
interval went back up again.

-Tony

