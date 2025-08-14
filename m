Return-Path: <linux-edac+bounces-4595-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88584B2718A
	for <lists+linux-edac@lfdr.de>; Fri, 15 Aug 2025 00:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603863BECAB
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698D277C93;
	Thu, 14 Aug 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8O2JZsK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE42264B1;
	Thu, 14 Aug 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209849; cv=fail; b=IfCaJAfdODh9jEHyGKnoHjrjPAte2Z1gTPs98x08rfOR96yGZXJuhz4cvAXO3PLrwrURHBCZbB+pbAZrRb0djGjfaSbP7TItZ5EvzDxztC2f768ozklPOtsS4WgpENYp9ZKVGubNQ5Rk0A0Tx4xBaq70EQYs7R3t8ipLZIeW+gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209849; c=relaxed/simple;
	bh=S+WuoqRONIOctcrtPIz/2E7ymXLWgN5nIJHRZzYnq4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pa7NF9yp5KTDOzTQ9CRWfWA4etB2Do6P+CqYS8jxpwEg3WHiHg3hBnmyTqKbAiLNkJI/Cx6A2+4vdgAoXIMHDNcONgtSktbph0S4fKkA7rXoCLfVruz/2ezQEgi+Duo2/bOg7MXKBgo5//3uGipJ6eQqTvsjZWkpHL1ttQg5Tvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8O2JZsK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755209847; x=1786745847;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=S+WuoqRONIOctcrtPIz/2E7ymXLWgN5nIJHRZzYnq4g=;
  b=X8O2JZsKuDuTl52fJaDzJ9zIkeFEhJ+QoNgm1y0VKwdFTiWu8JWqQSqT
   GPF3OM24zyQlncey1wHYsOhnJjb1jKmvx68+kEX/IOl/tQ9ODyml349Oh
   mg/9Qgl4HP1bNUZTL7DBmjgcsRs4nEFUbPhs0tg0EMtTPr1vAqfx6IabH
   GCQ2N47LsVKTqN1Pgo9b+QKbGnRI2Pw6Ws7i/vJG8xyR80dVL0RW8m4dy
   J6fX25Q68eQVKNifq5A3CB6QcQiYBLHSmwiqhQ/A3a2HOFTlvIDlJ2D8J
   Nj6Ru88lQxrjpgKG1NYByzr0uUe/J1RXrAOoT1OaLYWOezhe1dGDWJQit
   w==;
X-CSE-ConnectionGUID: o7qT+JCuTiGFOhXEzY+inQ==
X-CSE-MsgGUID: dw8oqMtUTi+SH5eXjhOwyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68238666"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68238666"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:17:27 -0700
X-CSE-ConnectionGUID: qTNBhmz4SoS7DmnjG7S2/Q==
X-CSE-MsgGUID: EDvmehrUT9CWoh7RoBQirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166840196"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 15:17:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 15:17:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 15:17:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 15:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiRgz/XteO6GhJlaKhHDG8yQpQkXI7i9vRTZKXCHyQO55YotdVDmto8toEqs7sK4FtmIeEiEyh5KHZtO8D+Y50h0qhjBah2GR7tpzD9NfvwElcWh2aW+YsGEda7eQtefezPODYL8eF4RlJplOC6jZfzsqKFCb3sd1KBuAMW6j7oLDpDCI/szlaqzwGhltWDIymuBQc5YDaFyjK4yPvL1NbWBZ5yY+k/FlIxFW762ZU021r+PSIQU5FSagUO2jogFyAaAWvdgikE9Eed2Xuqaaz9E3EcbAEoXyBZPu2IwtkxpcvYSsjRt1SlBIRFcWqkUAaliw2zroN6MpK+oF79P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs5hnFm9tTL3XpGL8tX5npnxPgEuLkj1aEqg81k/bZ8=;
 b=pVY2rhR+qEfP7Y1kbwVNRxR4MademqFP1rb7cDMGWxD9Bo6ypeOqPj0QltpjDuJ3vhP7HxFC0/phXTLOnpkNPoZREbz0CHyHqj7zKsDVtx7JfBJAZc33f72PbZAlBTA5fIUvm3tathnmWgKhuBE6Scb8fIRiO74uNFKwmZd9LD+zhQMv/Wtv3Wz7b/EO4vLU6NZRpXhmGlGvZHU0H+aMMN1Fgz8r1X9R/C2sHFPoL/1bIiTRFHF4Q7w1Auqmqqly1J+PanbEYy2WLrruFTMbZitKMbQ97eab+nP2LkxVgqdgVs300OQ/xaiGZQjWqNVjaxGDZQoJJUaVXIKl2uz66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 22:17:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 22:17:23 +0000
Date: Thu, 14 Aug 2025 15:17:21 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <avadhut.naik@amd.com>, <john.allen@amd.com>
Subject: Re: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Message-ID: <aJ5gcUsaKK2AXDsu@agluck-desk3>
References: <20250814154809.165916-1-yazen.ghannam@amd.com>
 <aJ4U3g4fDNNibUOz@agluck-desk3>
 <20250814193056.GA192444@yaz-khff2.amd.com>
 <aJ4-c0gNPbwwU3jk@agluck-desk3>
 <20250814210730.GA228071@yaz-khff2.amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814210730.GA228071@yaz-khff2.amd.com>
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: a824ac1b-515b-4e4f-82d8-08dddb8057c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk5RZ0w1V1ZxeG52WmIwNFhCaU50Si9TZmg0UkI2TGMwUG03VVgyaFpaMWsw?=
 =?utf-8?B?MHJlR3JLSHRsYS8zdk1mRWQ2NmV0K2dHK0k3aDRNWEE1NmtJQ2xiUXFhbVN0?=
 =?utf-8?B?RE5Za1RjVnBVQUc4UFBKM2R4alJ6S2g1Z1gxaFNVN250SzY3Y2VIRlRZblpO?=
 =?utf-8?B?UzVRWm9mY01jdVlDaGpZOEFwYkhsc2Jrc3p3N1ZIeU5NaElvWkx5SXluR2dW?=
 =?utf-8?B?WnhWRmpuWURVd041VVFmOGRXWVU1OUlvdm8rd0ZiaXRWdjZJRXBNRGlQNHpr?=
 =?utf-8?B?Y3F1YytGbC9wU3FoNmhuNlB0VGtlTGd0Wm1PV1A0Sjc3MEZBVm5BY0JXQ0Rr?=
 =?utf-8?B?b2k5aXJUaXVWeEVmWDk4aXQxVXZ5b20rVDZMZ0hVUG9UeXV1NjhtSEROS1pL?=
 =?utf-8?B?MXRKaGJQdXBWL0dUT2Yya3RTY25LOGdLTThqQndESUtZR0Q3aE12L0NYSnZY?=
 =?utf-8?B?cEh4aWJXTUFuejZKODJvZ1VHVzZObEt6WDZVQ2lRQk9hcHhrNUZ6NWptckEx?=
 =?utf-8?B?Z2loMU9UYTY4Q2NNN3FKeVZSQi9WU0ZHa0ZwdmRCVVcyaHE2M3RlU0E4SUU2?=
 =?utf-8?B?d05wVUVCZFhST0FqZEhPbGhOcUtIZnYzb0FwYklZOTk1ZWZUTEp2ZEYzN3lw?=
 =?utf-8?B?YVQwZkVWZk14TG9JT2VJQ0xEOG5yUW5yRE1zWk5UcktDK3hrenlTU2Z5bXhQ?=
 =?utf-8?B?aTJzMVBUYlpnR21RUFlUbHNwRjJSaFU3SmpoQXRKclFFMDNpS3pJaHFWMzhq?=
 =?utf-8?B?T1F1K2t2UWpQNm1lWnZsbGxNU2JCU3I3MlNPVzZHZlRzSGc0d1kwTVU5WFBw?=
 =?utf-8?B?NVdwaXQwVzdhd0xHS0gya1hJRjhRQWx5Zm5GQlExR0xoZ1ltMjRvMWxnNG9W?=
 =?utf-8?B?RUw0QUt2QllnTUdYc1J3aUo2bXlZQlV6QS81dk1ON2hKYURqSkN2QW1EYWNZ?=
 =?utf-8?B?UFUzMlZyUkU1b2dyUENSU2kyanVoSWQxQWordjR5eWFTU2crQm5jZEhZTGJO?=
 =?utf-8?B?ZC8zSVQ0ZTZ3OUJ0cDFVYjEzNFNtcDRXa2ZWTFZrYTh1Z0RKS1k2UWI5LzZF?=
 =?utf-8?B?Y29ib3IraGJmaDV6eDcweTlvbENqeW96MGl0N0xZWkIxUTFMWUdEWEw2RHd5?=
 =?utf-8?B?MXhTYVMwLy9qcS9zM3EvZTg3cndDVTNoL2JDWUVRTTNPVkdLQzhIdHpQZG9o?=
 =?utf-8?B?eTBGeEVpeDJUMTdGOHlmNnA4TTZzNVRYZU80bTdOZnFpV1FESjY5UmY4UnNa?=
 =?utf-8?B?bWRkc0xVOGU4M3o0T0RuOU5TUndVWjN6dTZ1VERiZ3Y1NUo2K0hlRHV6OWMy?=
 =?utf-8?B?R3JVZ0wwZFlUUDA5WW5uUXM3TXQyeHJiWm90M2xWUERyWFBFRkpsNGRlVFFl?=
 =?utf-8?B?MnZyUnRBRUNjaGo0L2ZpZW9TOEIzL2ZrbktUbFA1N1hHSURRSGMwMS9wY1Z3?=
 =?utf-8?B?WHFwekF1a1VhcHMzWkI2cnIxOWZQSVYvbjVNRUFBaHc3ak9BNUZrS2xFUS9S?=
 =?utf-8?B?L1MwMnE3NHNnVE90QVNweGh6clNPS3RIRnM5d0NHVUxKQU5KT0tVZTdwaHpo?=
 =?utf-8?B?c3FhMHNzak5FSzdueUFZdENBL2NVWHdmQWY3U01Yb0hTSjNUaC9EY0l6a0Jw?=
 =?utf-8?B?NEg2a3A0VXhod0I3TWN6Yi9WSXVDSFhreUZFUTZyblBJTS9jbDQrako4SWUr?=
 =?utf-8?B?NUJuZGxrdE9JdmExTmdwTmpKejBZY3IzTUtmMnVxOFpnNUJCb3lFQ3dqL3FW?=
 =?utf-8?B?d2c5MDMxNmQ4TktJN2czL3A1V0liaUV2dFlDTVhBQzFrSnY2MHdrbGFtT2RR?=
 =?utf-8?B?L2pHMUJGK2dhMUZZRXRXcmFXTnJvV2dmTm52TVZFeWFVdmplYU5icithRnkv?=
 =?utf-8?B?S01KMkhzT1duaTNzVzNOVDhYTXlaQkd0TmNMcEQ0Z1dLN3hwenZLU2xjNzg0?=
 =?utf-8?Q?qyKqRwCMpcM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZFa1JqbHlOTG1wWlZGODd5cGlNT2hQNXJtSUU4VDdkSXdqd0h6TU9DWko3?=
 =?utf-8?B?S1B5RTdMd0c5Zk9ZT2FaVDFEeHJLSmJwYXZoWVNoQjRqWk8rY2tOSG1ST1VV?=
 =?utf-8?B?UFBGVDNqRGN4NTA4YkQ2M0VaM3NWQUxMMi9pajdUUHcvNmltVWVodEVSSUVs?=
 =?utf-8?B?UXpLU004WjFOODVpQVp6a1Bmb3JhdlZ4ZlZtUWV5RlJKUEFQR2s5NFRRWE9p?=
 =?utf-8?B?WDNLY00xOUtkTXAramtpTStkNDRZelNDVkdoci9nbmEwSzRrUStxTFU2eGlZ?=
 =?utf-8?B?TkZPa240MndoQlR0UkJPdFZOaDExYk5oUzhENmNuODl6NTdMM3hGcENYUkZq?=
 =?utf-8?B?dDN2dnNrNjdWTWU2NVdvbWx5Y2RtSmM3ZytaN2VXMHl5aXNXSTBKcnpZUno3?=
 =?utf-8?B?MzlvRUl1MjdzRFhaVXBEdyt0VVhlUXgya2doTGFhNFd0c29zdFIxTzU4QVJv?=
 =?utf-8?B?L1NpMTZzNHBzdEZJTCtQNm1wNE9UNkh1SWJ0RlZsbGY1RGNyT3pWYW1oaU9y?=
 =?utf-8?B?MlFsRjdoOUpxNzZoMCtBUm1NNEtYMFVOc1Q5Y1lpRzU3ejlmQ2RtQW1FMXBr?=
 =?utf-8?B?UER6aGltVlhENVhiT2Z0MWNOK0ZMdUJ2ejNzYzh3V1R4b2lZMS83dzNaaGlF?=
 =?utf-8?B?NTZLaFZYdVZIV3VaZTdONlpEeHJDRng5cE5sSjQ5RndDbXNSa2xyQWRVdjZB?=
 =?utf-8?B?NjJiY0FkaS8xc3JFT2d4VWhYMFdsMG5wcjF3NUdrSnQ2enNIRWh6NzhBSGdn?=
 =?utf-8?B?QWZqc0lsR0ZwU0Jrd3JqU2g2REh5bmRxUFNNNUphTy9CTC9zYXQ4ZEsxUnZp?=
 =?utf-8?B?OGdnQmlpOG03dWF1b1lpd09veHpaek41RnlmaVgzOGxuaE5VTjBRN05rZHlK?=
 =?utf-8?B?T1hUM2hUZTlUWWIxeHpqc0NuaWpENlBidzhDUkRnNnY3ekdEMnluUHZGM3F3?=
 =?utf-8?B?NEFBMEEzQVdkMW5lbkJTdUJoUUVhZG9PckNZd0pya2RQTzhzRjZiZ0liR29L?=
 =?utf-8?B?QVQ5Nm9MNmFmTGptRExGeTNxcjA2OWRZdFZUZTRMVW1jaG4rNWczZEVLekRK?=
 =?utf-8?B?d2J6VjRZdERPT0NlNVVFRno5bWlvb3ZrTHlLQVNoOFBhM3BrRTlKV2dSS3Fz?=
 =?utf-8?B?SnFHNENLVmI1QWIvRXEwSFBadzFKR1RZNXhtbjh2d1VzUGo2c1huSXFRMmV2?=
 =?utf-8?B?TmovU3J3VlFHZ2JzbitqazVZdTBvK3gzMWQ2Vm5rMXBkdTJGamswdEI1cm5v?=
 =?utf-8?B?S3VadjJIWXlGWURmUzNxWDlUMmdSQnlKR25QaUE3U21vcHpiTFpGUkdwa3di?=
 =?utf-8?B?WVFOUFRjNjBhWHNoY2FvbjRaV1dweVZ6a1BlWUwyUDNjaDArRWNJYWViM2ti?=
 =?utf-8?B?Tkt6bjNuWFNIR3JDNmtLY0R4NU1MWi85cEN1NjF6b1VndndsWGVtOFJYZC9R?=
 =?utf-8?B?K0Z2Z3FWcldqcnVIT0lZYWVPcHo2ZXY0aEh6Sk5yZnFPdHd2cmt4OExjT3RX?=
 =?utf-8?B?RnY0THlDRTdBZStkdEIzbFFNdHNnUkFSWUgwSGNCZDB6YUtGemJKMXpGM3pu?=
 =?utf-8?B?a0hRWXB5VnhteHRjQVlBTzhmT3liL2dPc2hQNXduNFkwWUduQmpTWGhsTVp0?=
 =?utf-8?B?bDM4SFA2SW4wbFJ4U2RDdzJIQktRYnRPbzhMVnVhSFRMbTErODIwQUlhby8r?=
 =?utf-8?B?bUREUVl4b2V3NnI1TCtDeDR3WmN2ZldiTjB6WkF5N1lxUlNXMFlsQmJGQ2ta?=
 =?utf-8?B?ZE1EYU56UDcwc0xuWEZMUytXVU1Wd3M4L3l4Mmx0Z0YxcmJKRlRWRVNIdWRC?=
 =?utf-8?B?dGJEdC9tNFdQWndKc3BoMU9sbXlVamJRTitNTEV2TlJPSG5LZFFFSk9vbDVZ?=
 =?utf-8?B?ZDUzNmdrZnNtZUE5bUw0T0ZyQkp0UDhFcEhHWVp6Q1V4NXdBTklQWnVRWi9W?=
 =?utf-8?B?Q3pWSkxNczIrMFErdVlGY0hLdDRXZ3kvOGdlRFdLWmhkUEpRQ3JMc3FDdHB1?=
 =?utf-8?B?a2N2OW1CV01EWDlBMlpCVzZ4ZmxyTXBDOURkOWZldGNudzVGN0xRRXF1M3g4?=
 =?utf-8?B?eXNtZFhXKzdTdDdFdlh6OGUwOEJQeXFacjQ3N0tLZXluLytxMDFkWjZoYWls?=
 =?utf-8?Q?iwy2daPT3nVpYWPx37rNL8H51?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a824ac1b-515b-4e4f-82d8-08dddb8057c8
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 22:17:23.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txAwIXu4ZyFtt1sheAqOKMxnbS144WAyZjH2iJzJKFio+5yd+wZCpNz148Op0mQkdxB5fcKj6CxXCfhzrzOjtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-OriginatorOrg: intel.com

On Thu, Aug 14, 2025 at 05:07:30PM -0400, Yazen Ghannam wrote:
> On Thu, Aug 14, 2025 at 12:52:19PM -0700, Luck, Tony wrote:
> > But the first match nature of the table means that this rule hits
> > (becauase neither or RIPV or EIPV is set):
> > 
> >         /* Neither return not error IP -- no chance to recover -> PANIC */
> >         MCESEV(
> >                 PANIC, "Neither restart nor error IP",
> >                 EXCP, MCGMASK(MCG_STATUS_RIPV|MCG_STATUS_EIPV, 0)
> >                 ),
> > 
> 
> Thanks Tony. I see what you mean.
> 
> Do we really need this rule? It is essentially the same as the following
> rule:
> 
> 	        MCESEV(
> 			PANIC, "In kernel and no restart IP",
> 		        EXCP, KERNEL, MCGMASK(MCG_STATUS_RIPV, 0)
> 			),
> 
> ...since we assume "KERNEL" context if RIPV|EIPV are clear after
> checking the CS register.

I'm not sure this could ever happen. But if it did, I think I'd like
to see that message.
> 
> The message is not as explicit though. 
> 
> I did have an earlier idea that we introduce an "UNKNOWN" context for
> the !pt_regs case.
> 
> We could add the "UNKNOWN" context to the "Neither restart nor error IP"
> rule. That way it'll be skipped if we have a "USER" context and then it
> should match the one you want.

I don't want to do that anywhere execpt that Sandybridge instruction
fetch case (which wasn't classified as an erratum, because the h/w
guys chose to set RIPV==0 and EIPV==0 ... but it was a poor choice.)

> Also, I just saw this in the Intel SDM:
> 
> "For the P6 family processors, if the EIPV flag in the MCG_STATUS MSR is
> set, the saved contents of CS and EIP registers are directly associated
> with the error that caused the machine-check exception to be generated;
> if the flag is clear, the saved instruction pointer may not be associated
> with the error (see Section 17.3.1.2, “IA32_MCG_STATUS MSR”)."
> 
> But I can't tell if this is true just for P6 or all, because the CS
> register isn't referenced again with EIPV.

Should probably have said "P6 and newer". The intent of EIPV is to
indicate that this machine check is because of something that happened
on the current CPU (remember this bit was defined when all #MC on Intel
were broadcast, so knowing which CPU(s) are involved, and which have
just been pulled in to the #MC handler by the broadcast was very
important.

-Tony

