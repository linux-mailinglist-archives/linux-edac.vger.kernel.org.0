Return-Path: <linux-edac+bounces-1045-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C58C2C78
	for <lists+linux-edac@lfdr.de>; Sat, 11 May 2024 00:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1449E1F217AA
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447913D245;
	Fri, 10 May 2024 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZTrrQrV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C981BDC8;
	Fri, 10 May 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379165; cv=fail; b=rXuvGT2jHjCDB8Tu2XviTTTpm74YnNXFb406JwGdCl8uPBsZ+zkUdC3YAjXn+U7qvQG175/gPKoVpTDJeyfBX4Wqo4u8kaoCMlr2GFAMMCi4VP+mORsXhtP6QBhGxEZsX7iF3Uk1B9amhUwdojVuNCgPvaYjVByTHM6bfW3EruY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379165; c=relaxed/simple;
	bh=PlMSOXDB8vXbDtkyEGRdEkzZcw0TMR8MfKRUAgAI+Ac=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e7LLqifJBOxj/+KVOS9AtIqaUy4ayjkZzL08GmFQGpfr8pWvgEROqSvI+gY1QgK3EaoSPCRKxJJcci5x6pTZFmrjP5qTBDi5rF9/JmGAX05ZmFhAAM3R0blKneLAalMzt9ZIrS2eiMIQKrEiOGmRAh5laxOSFMlmPUUeUQtmW6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZTrrQrV; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715379163; x=1746915163;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=PlMSOXDB8vXbDtkyEGRdEkzZcw0TMR8MfKRUAgAI+Ac=;
  b=VZTrrQrVFWArAEeYroJe8iR/dbk36J8YOyUQmUwFUNwQ/jDDAdeHEW4c
   eOXTMSfn7wTZWmqivR72+xA0YR8RpgYD3prMvkWAZfeVygNJwHaJoWYUN
   M9WnPA/UqFCrv9PCX5rZVjMaKCYFqKAhEatKnud59Z65qU6Z6um6cseko
   Sx3yEZfEh/1g0HmPPJwlG6CU8uHUPr33dY2LKxEjDw9sDuTe4cWwgeeuE
   GC5rC5WG/6npHKPJaImw5cdDbmROCrhXNBqhtjxbpp4F/SBaQv3gcetfP
   mI4oZ5KL6XmvnKGXD3hPbmQqTh+X1SgLBQOScSzNLNiFnQ3TWY5pKf0wx
   g==;
X-CSE-ConnectionGUID: lwCS+Ws5SRG1k0nSzW6G+g==
X-CSE-MsgGUID: 3rrfyFMaTgeCQC1YDkJw8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11506452"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="11506452"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 15:12:43 -0700
X-CSE-ConnectionGUID: AWdECDneQo+EXvfkj31jQw==
X-CSE-MsgGUID: 4xndZUF5ROek94BpY2CsYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; 
   d="scan'208";a="29701479"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 15:12:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 15:12:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 15:12:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 15:12:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 15:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuYR3st8ig9oo40O8rpFoor3VTJ0ILL2pv5SSjYWGyncfOL78ola/GoTr1MlC6RERVXUZXsx60I4J0zJkzhSuACZ3+rTArhVyPC1T431NVC5d+Y70hhj4fiZ6josnrKCGNIVq+c7vsIYMlwCr/dPra/IIH4+yEDb7f1Diw/xvOBXctgbYMATV4qprT0kzl47h0LTYrj0frOXXOzkfholXtEzGK/8rli3E1OpaTQpvnov4JYo1Vn/4/6tTIJKfv/ElR8St6NCTrqGGdUPrf+a3iy2Mtl52J4xVlUH+657+6Nc5x+lWqccJSoNPDzcobjlMKSamnWC04jdN1c7NYtPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbIDVtm7EceOnFYTITKbX9VNz1/EsKpkwGPfNCp3DMM=;
 b=mOaGHYnLxsmljoX18AlJI+JZDsjjNfIs13epVn3XMPGNdygnAusci3HBPiuyNhS5ZrjxDVO/QKlzXZeLK8jfDAugY8qGieHMHMW+od1WLjyB+qCLrmbrY5sAi+70M/9sAyxo0iJp0M044PAvGwwkyH9V5yFhrSE+QlNPuhBNMCzL3splM1cGblXT+HqmztqJruaCfLCiJs51BhNHQTyDa4upyRyjl14mRfZvRqwlXy1GUbgZZlIA2KLncLbultGKdh1OajFvj0r0R6WkgoM/fdjTOYJrHCDNp9+A0v9amroGOHg25tXqsPHNu49xTgVSgIkz+tbf0pHis/uBaeTMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 22:12:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 22:12:39 +0000
Date: Fri, 10 May 2024 15:12:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Borislav
 Petkov" <bp@alien8.de>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony
 Luck <tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <663e9bd4c2525_db82d29451@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
 <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
 <2881368.Ex9A2HvPv6@fdefranc-mobl3>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2881368.Ex9A2HvPv6@fdefranc-mobl3>
X-ClientProxiedBy: MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f17389-9c85-4295-8c24-08dc713e4e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUlTUkExL3hJNWFCcFp6a29oaExiajRFQ0VYZ25POEtKUXFleTVxYzBQVjZs?=
 =?utf-8?B?OFdIWDl3eVZMOTF6N2I3NkhDZG1aQWorM0I1L1NuWE1vT0lIa09vdXpvTlJR?=
 =?utf-8?B?ZXB6RnV3THR6Y1hjanNkRDNBcFV3OW9OcGNkUnJQb1dzRng2dkNyMDQ2Qjl4?=
 =?utf-8?B?SHBkQ1JOU2NCblh0aFFuclRROGdDTGtjOGxEeWpHd0NpdXZQOFhBNW1IaFc4?=
 =?utf-8?B?VjB2aDhmN01QcTRWQ2xmajBXTWZJVkJSUFYrNDFEVTA2S2ZYTU1ONTlNNGhL?=
 =?utf-8?B?dGhuREN2N1lOR2tjYWUzbUNZR3ErRUxFclpIOU9aZDQ5Y1FCc0hTWUJmb3VE?=
 =?utf-8?B?MUo5a0FKaWJzTnVkbEgvUzNEc0l0QjhwZzVsV01FOENhZUsrWFgydTNOa0dV?=
 =?utf-8?B?R3RwZGI5RXpScFR3bUk0akl5L0dkVzZzVDdWUkh0V1ZCdFhrOFBUc3hVdk02?=
 =?utf-8?B?RGt1NHduOUMwSTdWYzc5N1UvdUFmeGlyc0lkRFo3cHhjc2RTaGRmZkk3SUF6?=
 =?utf-8?B?cTA1VWNYemN6M0o1RFlzVDhUOVZVMTdkcXc1SS9XMDh6cnJEd2tSV3hSclM2?=
 =?utf-8?B?ektCaGxMZ1EyclFPSUhicUZONVZ4cDFmeUQrbkcyTnM4OVlTWWFzaUpVY2du?=
 =?utf-8?B?dTVmaWJEOWN0ZnkxS0MreXllaXJYQmY3UXZONld1eXRmVnlPN1RLQURjVDhZ?=
 =?utf-8?B?dVgwVUtxQy9PSDRlQUdGeGMrZ2o0OEwycXFhWUFmd1dXemg4SWNsd3NRekxR?=
 =?utf-8?B?bjlqSjJ6aUNTS3RUcnRzazc5VCtWMUdveStEMndPWnJOdE8zSHVsbEtuZ3dX?=
 =?utf-8?B?eUswS0E4MjAwb3kvWnlDTzIvSnFLZ2FseHF4a21raVgwM2pGVnhFZG5HM0VE?=
 =?utf-8?B?SVVEY3NSRjlqRFY5MXZMSzVGaUVBVlN4Q3VPN3huT0pYU3B5bFBsa1NyMHAy?=
 =?utf-8?B?bzZxeEs0WXgyaWY5a3dHV0dlWVhHLzFENWJDd1JYem5HemJYRzdaNUw0Qi9W?=
 =?utf-8?B?TWYreFI4STVOb0ZMQ1Iwc241bTE3eW0xSG83ZUVNeG9STTQ4M1EyZ3l3eU9I?=
 =?utf-8?B?Q21uN1JBa2ZBT3RmVGJzcTdlUDlRbGxGZjZ2NTl3eVVxQklEQ0pPeG9YdExE?=
 =?utf-8?B?N3pFeFRkeklJc3QyOEJEWHNkazUva21PY0t2dHZYcUlmM0V2RDd2TmpFNSs4?=
 =?utf-8?B?QXJVdklmVnlPWS8rZTczWTdPRUx0UnQ4aWJhRVJ3SWk2dVRoSWttOElJRTNZ?=
 =?utf-8?B?bVZOTG1mVFplRFMrTHp4SEc1WU96MHJFTHF3UlNlTlI1eStKUWtJMklFRVRH?=
 =?utf-8?B?ZlAwcENZZ1lMdmhDQXNGeWRCZTdFOU14aUhBR1hRREhLbExHQmdVQjB1bzJ2?=
 =?utf-8?B?d1p1WU1JVmpaUWlhQmJwNkZzTlBiY2dvN3crcGdxTlR1eVFsQ3A5dnVrQ29W?=
 =?utf-8?B?R0ZrRDltUXRVYzJWV1RackZwZ2xUUDhnMnhsOFpPVDZCQ09jYWRaMXNuVkw0?=
 =?utf-8?B?a3RTOFpjSGpBV0JlVThGNFJsbnN2bWIza1NLeHpuVnQ2bytIQkNpWkhQMjdn?=
 =?utf-8?B?YWZ0QjMwUVhPNFRlVnpyU29JSC95OTZHYXM0UHMxdGxZZG11em1PY212YUM0?=
 =?utf-8?B?SEJUdUtXMTlsVjYyREYxaE53Q1kxbHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akcyUlRiZFlCLzlEaVZUdlA1aDVOUFdCdUZLRFQ3cHRYQXhhSVcwSjZGczdI?=
 =?utf-8?B?R3JqbTJkY3Q4dlprWGFPdmEzK2hONmJIbVpweXovRFdPOW5pTUY3SDFOSEhL?=
 =?utf-8?B?TXcxL21IM0hnVkxncmZoTmVINmxqVEN5WjFKUTAxcURpeUJCaEp3Ukd5Y3lq?=
 =?utf-8?B?enVYbzk1WS9OaEJkRVBjUVN5WnhWemtFd1lYZUJySW9FcFhQVU1vYXM2NXRn?=
 =?utf-8?B?Ry9ZSUJ6Y09JQXdNdmlPMm1aMmJmNWFEWmN2eGY1eXZla2pQTHVBZFE1eWhY?=
 =?utf-8?B?b2NMVVBwWTBlZXVpRUFyRk5sSEFKazlGVzhQdXhJMnlpd0RiYzNYV3ZUbXh4?=
 =?utf-8?B?NUJNMVFjSkNMSlJ2YVV5ZEtKTTVHSy9sZ28rRDJuQklXTmk3TmFFUVlmU0Zm?=
 =?utf-8?B?enFFdDFHR0UxRGhMNmY4QlN6aGRRbmp5ek9WYWU5UkRFNWJ2S0FDd0JoVGk2?=
 =?utf-8?B?R09EOTlScUNGS0lkWExRZFhTemF1SGorc0dXM05oSkVrdFQxQkREcTJYeVRq?=
 =?utf-8?B?bnhDSWZPekJCZFdiVTlydVpRT1dRTTBVV2Q0ZG1melIrdjFvUlpIZEpQWXpi?=
 =?utf-8?B?VlRxQWc0SUZKcHVPWnZvL2NDajlLVnVvN0piOGZrYU9rQXI3aHBmaGtiNG5H?=
 =?utf-8?B?dEhpTEZMQWNkNHBoazZxS0pUQzI2cGovMldZN3ZBOGNOY3Z4bjFTcm95M2VW?=
 =?utf-8?B?bjlnNStmblJ4bDBCOFFVK0lzN050WFM0Qm1WZjdzc2JOazZrNWpuSXhLcXp1?=
 =?utf-8?B?UE94d0pVbGEvZkxLdU1KQmNWWDJ2MkswbFIyc1JBWU8rZ1lyeUdOdGtSS01L?=
 =?utf-8?B?bzE4VmduOCtvWnVRQUhtcVhVWThpOEVEKzZUaW45UVEzQUFDL0Y0S0VQM0dh?=
 =?utf-8?B?YWNaOTFHd3laM3ZPZVFZcmIrVTN3T1orTE54MVNTaDUvVEM5QkZHeXU5YXZI?=
 =?utf-8?B?WGN3MXBsWnpZcy9BNGZ3eVkxYW9sMEM4SzJ4bmtRcG5zU01jMzJDSTZBV1lh?=
 =?utf-8?B?VDVXV3BDd08rOGFUWi9icURiK29CczFnNnRxM3E4cWFIcEVCZTA5THVyTVI5?=
 =?utf-8?B?T3VZWjNtbjNFTFhTbzAxSG4vTkxlbU1PVzNYWkwzeTNhR0J2WDU4RTRZOXls?=
 =?utf-8?B?SDd3SWs3UkREemNXMFVRQlhMQVBxSDMzQ2tXZFR3LytWNGlRemRwMk9LUDkz?=
 =?utf-8?B?VjI1a0ZmbTU3eGZBSWNpb242SnY3QWswaitnUkNNeTZUNjAvMXg2cjdwZzRP?=
 =?utf-8?B?VDhFaHVNYUFDSFBDNVdQZHNqZXlLSUdNamJnV0lVZnFMUURRMTl0TWg2cDlu?=
 =?utf-8?B?aEU5dU0rc05UcXluL2ZaT2JiSWk4QzVQenU3UkRpa3h2VjV6TVhRdFpNaWlx?=
 =?utf-8?B?VFBGZ1piK1lGdjNmMS90RlZ2ZENCRlhVTmF4Y1NQT3VqWjZFM2dpOWVGU3pP?=
 =?utf-8?B?Tzd5OGdqbjdOZ0hYaG8vdE5adTBjbWZpY2hkMVZHeEtJdUxYWmhFcUVJbHNn?=
 =?utf-8?B?anp1eGlJb2xRYVNYZ3FJQnJSRUIzd0tsdktaQ1kvc1drSGc1M0F0MDJpYUlX?=
 =?utf-8?B?TXZQQmVDUm16SHdnWE95NldpMkl3dDF0UnZWc0ZpZGNhVjVHOXZJZ3RVT1hE?=
 =?utf-8?B?YndYOW5HazFBYUpPQzRUTjNrM21Va0Vaek92eVhRTUFXU0NnYU5xcTUxd2F4?=
 =?utf-8?B?Rml2ZUtFR2V0a2lpZEJPU1M2dWpaS0xVcEV2Rm1CM2FEQU01YStTY3FUY21T?=
 =?utf-8?B?SFZyZStRYU9HZ1pwaEZ0a1crT1p4TDlNdmpCcXJCRGJ0Rm9jY1U2SXZ4R3RS?=
 =?utf-8?B?RHNBdEZ3MktJd0RGcyt0bW04VmxoNlRxR0hKcTlBVk12UDE1clNlU1NmdUZR?=
 =?utf-8?B?LytYL1FrME83R3JJMVBDYUM2TXNIR3BKY09RZ05mTTRaRnErMXlLRU9wZDNL?=
 =?utf-8?B?bFNGUFc3bGdZS05QRFZGRGxKejAxd2U5bko1WVNYblFPaTFlMzJvTFNmSDkw?=
 =?utf-8?B?dlA1cmQ3M2hJU3VuTmllOEN0NW5aeWJlMWRoS1FqMit6SzJNVlVFTmFERU80?=
 =?utf-8?B?eElPSGg0VWRsN29zV2xUdC9WSEVpNzY3akszVjd5akFacDRNT1k4VDRIcnZD?=
 =?utf-8?B?b3hQeGIxcHJudmM1VW5Va0xNdTdLNmhodnVHZU1FeXNUWXNmK29ualVQWTNX?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f17389-9c85-4295-8c24-08dc713e4e0c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 22:12:39.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYfpQhEMIBQJOwSaQbSrdXkZykfuYt/upfEcLqwjMP5xoHKP7svTRDr1fqCGeonNsFcvmMO9dsEK/4UZcxqJbbX+/vUrUBaVA4Ff0HveJXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> On Friday, May 10, 2024 9:25:56 PM GMT+2 Borislav Petkov wrote:
> > On Fri, May 10, 2024 at 09:00:34PM +0200, Fabio M. De Francesco wrote:
> > > I thought that ELOG and GHES should be modeled consistently. ghes_proc()
> > > prints to the console while ghes_do_proc() also uses ftrace.
> > 
> > ghes_proc() calls ghes_do_proc(). I have no clue what you mean here.
> >
> 
> My understanding is that ghes_proc() logs to the console and ghes_do_proc() 
> calls the tracers. 
> 
> Therefore, GHES at the same time always reports the errors via two different 
> means.
> 
> Instead ELOG depends on the check on ras_userspace_consumers() to decide 
> whether to call print_extlog_rcd() to print the logs. And if it print to the 
> kernel logs, it jumps to "out" and skips the tracers.
> 
> Why is it different with respect to how error reporting is made in GHES? 
> 
> I thought that ELOG should be modeled similarly to GHES and so it should print 
> to the kernel logs always unconditionally and then it should also use ftrace 
> (no goto "out" and skip tracers).
> 
> (1) Is my understanding of logging and tracing in ELOG and GHES correct?
> (2) If it is, does it make sense for ELOG to print to the kernel log, 
> unconditionally, and then call the tracers like ghes_proc() + ghes_do_proc() 
> do?

I had asked Fabio to take a look at whether it made sense to continue
with the concept of ras_userspace_consumers() especially since it seems
limited to the EXTLOG case.

In general I am finding that between OS Native and Firmware First error
reporting the logging approaches are inconsistent.

As far I can see rasdaemon would not even notice is the "daemon_active"
debugfs file went away [1], and it should be the case that the
tracepoints always fire whether daemon_active is open or not.

So I was expecting this removal to be a conversation starter on the
wider topic of error reporting consistency.

[1]: https://github.com/mchehab/rasdaemon/blob/master/ras-events.c#L992

