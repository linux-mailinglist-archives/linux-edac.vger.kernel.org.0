Return-Path: <linux-edac+bounces-4590-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832FEB26D0A
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 18:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B45B7B627F2
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77A1FDA92;
	Thu, 14 Aug 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnoerzNo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0831E522;
	Thu, 14 Aug 2025 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190500; cv=fail; b=ZrKZVgR+ZItA6Ano9pxKvJkOTwssBQqrqrmMBHYMNuqHWMxluH6EiOkXlyW/k2A02M1KHsL2B7dYiKh9fT45bnuu4HYmRs9Eg5k8EnGgHpR7RGK+KNFBve9vx6jDvqDozGd+c7vFxbY6Kne4PgmM7SA7yZ/axKe9ydEq8mlgckY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190500; c=relaxed/simple;
	bh=yh7DWeY2gJ5ljEqQhAYYO066xc3E02IU1/tSEF1HyMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBuFdg2JFJfx/mg6Vi+AbSzRbTHLWW/46ipLfAVB83az7kPOVWYK2ZRqTN8lkQOEwio62L0Cyd/U7+MTNwaxOrJEqK1ZoKS7V5C/YWJbRy9gFqSYhC1P+8fjXb48xAWI9NXkA3Mc9cf5GS5HoiJqoYMT5R7Kni5oMr9UL9VdaBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnoerzNo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755190500; x=1786726500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yh7DWeY2gJ5ljEqQhAYYO066xc3E02IU1/tSEF1HyMs=;
  b=gnoerzNoi7UlPjTudKFvB/9pp44WzNYK8r/gggVOWhNrNfKIedWSzQhI
   GUphr12SckQO/AjnIMIYFhbVRcVv01zYGFNXxYYEYVckX181HE8KV9dwp
   aFws7j6rAcxZbsVEVPhSnppRkJnPHyS+HjFLeaqi+RKdsXnJ3jm7x+Cej
   HqxvgsjI5WYwG4BKMaSOuD/LO1rkjACHlSjfdhjNsMv92CnjKoLyiRbce
   iT0I6G0XuPNIdMXufCuVs0dygW8mohz3ZkFR9NRHP9wlA4g8/W8GQqiJu
   z9n2wugo0aXtS7advWTMBduqjS/U/eU7HojG+vSKprqhcxgoKEPIWJhTP
   w==;
X-CSE-ConnectionGUID: 8vmaCx7DRcWZ/x4V62okKw==
X-CSE-MsgGUID: O+Nc+JKLTpapzmGFr3SvmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68890833"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="68890833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:54:59 -0700
X-CSE-ConnectionGUID: lF8wjkMYQnmweBw/eCVAXg==
X-CSE-MsgGUID: m8XK4pohTxa9weQk9vvVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197801186"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:54:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 09:54:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 09:54:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.82)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 09:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIL4CKEIR7FvbyOyi8Tdh0xS1ITNnyAlPSQZykON/JBcDfGEQsYnrSaNT3p26jRmujl5S4/9346n4NGwjooJYuTDs/NnmeHnYEHFJA9XtzcDIplR/x+7722WbZjPSW8LVQGO73PYNtE1mKJm5FHVKMnEQTbAC3PXglDMCxkrthKml0+wqSkYSd23id14akReDiM4f4onkh5j/LLf8cAr98Vjh32dy1Ks/haymzE3/mDjdgxXPUsK+uk7WEmTqmtt9v4hT2kGunAdWO9KwCBf/Rv+L6hQC4PKP8mG7IWlku+0uCJBcewTT2rCIxHNZ72IULDMpX8XF7huHQNaJdhwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yveRvjR3UDjtyapxCORvwdS00nwGIB/EdF5VPUpzJR0=;
 b=lp+XSkP4YlX+tjzPSFr4bx7UA1ihk+k/UtfR4VguOvVbJDwl3srrR/gEW9vjJI4i4gFtykIUspQ2VhqOe2Y88kLrG1WgW/roBDeG9HdYQM16vmXOsBaoyQxe5Nptsaij9q3ezll2E3UncuNlprgzFrLiTDMxp8Oxt0Acw+NkSjxLiPOcA0GcM9cr3Ql7gEVOvjs5rMUEDmQ4mBEk5GNSHiExne7G+uuxuXjyuVA7JCoBrGIzYDgh+ilw7D9LvI7rIeytQulDvg3nb8faicX09dKhJIZuV9kR7UGOECLctUXur+7JnYWIJYbf8w7xywAxKqMQREnBRZnl2A5f+4Gtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 16:54:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:54:55 +0000
Date: Thu, 14 Aug 2025 09:54:54 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <avadhut.naik@amd.com>, <john.allen@amd.com>
Subject: Re: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Message-ID: <aJ4U3g4fDNNibUOz@agluck-desk3>
References: <20250814154809.165916-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814154809.165916-1-yazen.ghannam@amd.com>
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e0b3e4-ea0d-4862-b751-08dddb534b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vXk6a/Oz80dYVETtljQtODEAi32lZFEccw28177JCzXtRydgeM9HtAaUDOs+?=
 =?us-ascii?Q?H+mmLn8PPd1Mshdx6P2DuIH0Y0iB2tb8MzKp66KdvV3nNVIWa8NAkKTM4EcR?=
 =?us-ascii?Q?Yi0DL+yvNU+T8C8twcGabtx/Pk9iL39fA8ruCTMCLtjMvhJV2kr+P/MFlr1R?=
 =?us-ascii?Q?p8aD/JnAEq4LwggPVigaBJa18ky3mHqWj3IY4hGZT1c3BtABOdJ+fZ/jz+dr?=
 =?us-ascii?Q?7vzWU9O5u5fGiSEsKnMn6seEwZTvhiQwKeOVUeWs8ciA1Vh7gPUPerFZzeZM?=
 =?us-ascii?Q?zQjUEHAXZLKKa7is8Fu7g59068Aog2vkFHXMAmWzfwNz5vpfCl/FJF4/xW6P?=
 =?us-ascii?Q?RLYVhzbTCSVX9Yhkux1csX7uQH0sxZn0VxSBNEGW2vLJ4TUAReve+RMOkn56?=
 =?us-ascii?Q?nZCwnvQX2bHDUIX/Y+YHpwGzoeLW2Jo8E7Dav/MSsXI/gx8iUVART5PDX8I4?=
 =?us-ascii?Q?SzdCIK+xOxZjytG/ui7gR8uu/pl2Wzm4xUibW43LfO7FXy1hJa0X6QdjqIBb?=
 =?us-ascii?Q?Ce9P3HMp+jCR44eN64l/K3+fQu+l53ScsN+fPN77RmtgrRZooErmPg6YcXNs?=
 =?us-ascii?Q?7V2IGlx+UZNJdgK63ZRKqFXfvIcbYDPCa1sKd+cbj8xYvYjtWE2BkD5PQpuy?=
 =?us-ascii?Q?93C3laIPcnUb5+nDDNs/lAG255XIfjsSWPDcRRs6z+mNQkFG/RISp4mtsArJ?=
 =?us-ascii?Q?y6Bx4vKBf9P6mqMMJqBl7358f2bPQlqW1pCeCGBVhDM3QxYd30LCSS2WBPb5?=
 =?us-ascii?Q?BoluB1yDNVof60U9AozUZO9FelPdpQx4wrEZlHg6OYwEwHgGpL32fNwtsRML?=
 =?us-ascii?Q?AQIfgPMshtN2cevEuPIrRhMbGr0KCP9D+bnUYMSB9XxL7nIkW4/C453Ndp/A?=
 =?us-ascii?Q?cdb2lnDbe7aciG7KirvWi8thOPO0Ius4jSHtjYYyY1dxczfUWyxw+bPz7WoZ?=
 =?us-ascii?Q?DJYj0TetWmCIAJt/6/Dekm1kigSLk2C/4QHCpUqPGZtkBrEd9e4uyzhxFeDh?=
 =?us-ascii?Q?D5tuYp82JZhZOaKkkzq5Xa0rkxeG/ZSxt4mbuVm6d9CWADoUE2fUfU2U6KEJ?=
 =?us-ascii?Q?CwVtRC+N3QLCGuKVJyO9YJM3THSh/pk7FnWKf+BKu8Yx37zKwOwK7yKjftyX?=
 =?us-ascii?Q?JIDK3X3XGnk6DVddG0qmpkZflL4/KVEx9pyEXaOty/sX51f5yOmZlQCkkIyK?=
 =?us-ascii?Q?TgebuGdicOtJw+66n78AZ+8JayOM2J0Ei1v6fLIc0HvUiVYKmwrc2qn2FEr+?=
 =?us-ascii?Q?KhzzbLiCb7b4v7uBehsuNyGYPpdfCRdbSrCsJ2V6m8xTywpLqAuwMRY4KlVD?=
 =?us-ascii?Q?aqB1RD8Q7usJyPVqpMcM7tJ+lspZsSgrvVpFBOqJdb8QKCaxMvKAMvHxjCYD?=
 =?us-ascii?Q?G3nVKrb4MuDPI/PpH3TfpmNmIWBQbiDhPih3GIvUyZv7BokXXhEdCJ6QDvnn?=
 =?us-ascii?Q?4/dtQMbZWfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MSyKUa/UZRqN0O8NPhsl8YcT6pNetdhpd+nESTziDvowGceN2Qyw4SH4M/Rb?=
 =?us-ascii?Q?hfGMPVe/wMsjPHw4gXZu6KagXT7DKD+/H7uSDeLPnXxnZvzS1EdUZznV9RBO?=
 =?us-ascii?Q?syltyTHZawMgFYU9+paGmkRvVq3JWExjIvysXVCarziGXg8DPQGVfN3FERJq?=
 =?us-ascii?Q?Jtg5GMyNgIK5wmS/H/3gJJ4IhCzlN9Uge8GQjscHL4J0vDE0Uvh4RzTiDo4y?=
 =?us-ascii?Q?OHmWGB9d2fFQJ2rt8GGUht+i+Ns2790l3v9bJ9Q9ENEOw3S885RshAq61+K5?=
 =?us-ascii?Q?97lOO8dGhkXdmAEPBGvW53ghCR620xgOHR0CXu0keDk79pK2taxbq+Rxvpig?=
 =?us-ascii?Q?8pJZsmmT+UYf2jonW7uysucI+5AtQFmcKZmqrDY3Hf+tp6rCdbAuBsQ0Raxg?=
 =?us-ascii?Q?KH3U0P0SewoP76H6WvGvce+klQDPOSzz3jxG7+4q2Xv1Lh7maw7JxoUu7hCq?=
 =?us-ascii?Q?55Hmx/c+4Bv3thrNQrw5hUzUbOiobcrV/8iOHzfjgNgqT1LatGwwXpW7GsYQ?=
 =?us-ascii?Q?kh63VJvWK0aP+1h70l7xDEBD75PzzW0Jhluq+h7pcOAXSufM1HHYQDo/QHkP?=
 =?us-ascii?Q?Ywct9xb5mPw8TairettAxUKo5cYrNdkNiGWJnLPsnhRsGcmfRNFZ3SzaVSeu?=
 =?us-ascii?Q?mHDWPwziRZEtT8D1IyQT/tfGg/xmWF5Kd1oJMQxzEWMy1A19dAXgJYSl7YBO?=
 =?us-ascii?Q?waz/rPxSA63f4kN106GqZN9MiEa2+5SJB00oHN3jFiMslLqnp+pXbAA4Kzpv?=
 =?us-ascii?Q?A5Q2BgrIg0yE3VmCZolO4KSvxVHawP8EeeLKEyy4/aNxJH8df0DRsn1tt/34?=
 =?us-ascii?Q?iYY/uDMhdwSv3vdZ+To98FvQ0Yb9J0q3x3QxPiSaMCA0GAIHXRE924ock2ct?=
 =?us-ascii?Q?k6YJ0WTlm4qX7ZqusXaaL7H2bt7fRqMFbPGmNNnQDEYNAzl+nIKrSb4EwPwC?=
 =?us-ascii?Q?e6vHN0v/Hr60ImiUPs9F8ts3my7EIdLNIQqwJu2ZHfwPE4gURndTnYmi0wF4?=
 =?us-ascii?Q?UWz32HFcRMkEDSyOZhOzMxiOgisRJ8AouHDBwnUvWJWLbRjPncET3gJAa9rr?=
 =?us-ascii?Q?DoOZh957sk2EXC0JO1y4J3gt/kwWSWidiqf0GzC8WngZrCReFUUaRs6R0SU5?=
 =?us-ascii?Q?iYql/KbkeytrXRoxAQw9044ccN/E+y2shwanycSCh77p7OQqJR6yH39fGn9q?=
 =?us-ascii?Q?+CMsYBMRGEvxypqhxKRPskTEBiecJeSKXzV3P97KkSODNRDvXPVhQ91dQ0y2?=
 =?us-ascii?Q?z4OPpQQydu88ivZEjeyObFzm1D1D15OT8Honx7Z5osHnXTgpeBDVEFm0FyzX?=
 =?us-ascii?Q?eTxz8rkbnh5r/3rfBOUeGUrtfO4uSH1/vBfPP4cbXwdcREqyNfyGQsJrzneb?=
 =?us-ascii?Q?Rwv10P3A1nw+jT6FuhZMO5wJFKWCxMqPuVznhqc078oLpcCPHjeWEun9EY9D?=
 =?us-ascii?Q?L51fxe7gNkS/nvcZN6G6fYGrAJWS5j5LBnoIEyD1rmYHewfGUaESZ8t1nd1a?=
 =?us-ascii?Q?R18jCeHoMoh3Ez2mRYaGopySHQ0TEzBf19MTs9Cvu8iNgIHnsjC6+X3Y7PLg?=
 =?us-ascii?Q?Vxqv6ts5RgfbHh0ccVVx+1kSFN0DM2P7TuJgS9i5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e0b3e4-ea0d-4862-b751-08dddb534b9f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:54:55.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uf+7mRSHSLwLBzYv6Dnvsj/n3JAw0ak03LzDJn97Uahtpcduc0W3X4yRcP5ZCxfD3DRffgKcCHBkpLsuI2tgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com

On Thu, Aug 14, 2025 at 11:48:09AM -0400, Yazen Ghannam wrote:
> -/*
> - * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
> - * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
> - * Vol 3B Table 15-20). But this confuses both the code that determines
> - * whether the machine check occurred in kernel or user mode, and also
> - * the severity assessment code. Pretend that EIPV was set, and take the
> - * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
> - */
> -static __always_inline void
> -quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
> -{
> -	if (bank != 0)
> -		return;
> -	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
> -		return;
> -	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
> -		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
> -			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
> -			  MCACOD)) !=
> -			 (MCI_STATUS_UC|MCI_STATUS_EN|
> -			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
> -			  MCI_STATUS_AR|MCACOD_INSTR))
> -		return;
> -
> -	m->mcgstatus |= MCG_STATUS_EIPV;

I don't think this part of the Sandybridge quirk is covered in your
new code. Without EIPV set, the Intel severity table driven code will
fail to note this as recoverable.

-Tony

