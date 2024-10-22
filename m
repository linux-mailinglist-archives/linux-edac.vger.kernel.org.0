Return-Path: <linux-edac+bounces-2184-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5269AB5D0
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD761C20E75
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AD11C9B79;
	Tue, 22 Oct 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOzUGQfH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACC1BE23F;
	Tue, 22 Oct 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620769; cv=fail; b=aJjDpSl91EUL5zlddoxnFxWgTYmkAYCWlu4aa1pEvRcU/C2XTyZTOLvDy0d9AvcrmDK7qe0MDL4Zj75Lynaj18wnu+m9v3X27tMO7OqRtotV8mOsXAN83M3Z/Pe/ljwqeEArmisPI2loH6ZEl21pwyn07W3VXqPk2CDzwzAEK3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620769; c=relaxed/simple;
	bh=D9mZ9x0Pfc24W8wEbHUmMiqZlAvNFtMlq0YP6ICTgLs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNCnIMqFWGnp8MqtVFN+GWwLKC3gHknSp9sg/5bbz+jzg9w2FrwLczYDaVJ+ZeHLMh7Lx6dXTZSSh2JhBdwvGx4zfHrLWxANMUxDWUnqR3kL6q+UAB1TXfgEp5YmecVdWKRmwMpGpBhIk16nCAUa9YIsC/kVCoe8Nxz6KWQonW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOzUGQfH; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729620768; x=1761156768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D9mZ9x0Pfc24W8wEbHUmMiqZlAvNFtMlq0YP6ICTgLs=;
  b=LOzUGQfHAcDNa1f6ZKtp2VKL4dxqiTVKCTwclypoUvGqUducqTq3HOOX
   ghC27eYXy37dO9De94o4Wa2i7GkB03TkTikxL3RR5jAZIPbhOy37Ze1eJ
   2ei9vthYAb/fob8aJldp97GGCLuPd/l9F4Wf3BjPzOcZU6z3fl9r02qW2
   y6WaITEHWdfwfNhScPNpaA0WF3wDgaNRLeqg+bzD4GAwspN963UB3+zrs
   XP7qD2lWdyKq0sQ2JOUW5Sar/GLjLvh5vuKj6/k7+SyOVqu3BawNHvn9G
   Qu9Dk/9KoPkRaVM47QxYLBR747R4NP/Q4JKAC84RN5cG/wyPF8QvGviCv
   A==;
X-CSE-ConnectionGUID: E4gPgc+YS6uBs8S4aALj7Q==
X-CSE-MsgGUID: KEnJSWRnThyQBdZxnKzn0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="39755740"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="39755740"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 11:12:44 -0700
X-CSE-ConnectionGUID: 0cyWwmyFSD+73bylhKVBJQ==
X-CSE-MsgGUID: ABOd5jD+SfmJ+cVeUWoAhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79962351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 11:12:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 11:12:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 11:12:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 11:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qieiPGg8yzs0+A3TZ04FysqUDeUexN6i3ENZVGPZ2o/zMeJHMc//8bYiG1UsM5dz9bNmbN+kzwg1E0mXKQjMVbA4gsIXzoJdIAd9MAnXkZWBHfxR+UyQD7B730nk9p61i+PpNGovNqUI4z6bSLEafLaeRdO/vJ/Yky8eCMZX0OThY+V6UetXRSbQUzuymUsX7OFaeehBNAdzPtjvQktJq9r6t6lZmYXEGamVHp5bf1pgMMe+tRAMXFEuXZOMdhWdyfA6hN+ZZ14hNOgir98Ke3lf418qr5pt9HzHQIchYYs4dbuVAh/Ltm/zCRuMSUEsFeGArK2AUgJbEArBX7BuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAxMlnIGkojl4Ip3A9pd7xzacxoL+Z7sI+71tEehdEE=;
 b=n/D9rV1x+R1LOvFQ/Tz3r1abY29Trl15d2vqX8p58OE5tZl/VYdhxd8IjhTRuodpk4wap3dO/SHdBxNewdDvta0LS1yfRfvsp/NAdhAlOzTjLnP+CPip6XH7JT29ADVgpTvFbnC3GN42do04nBU+jJbNHzuPtjG3RUEcCtBopip5PooJYxmf6hGXeez3vpX1JTkTIXtyCa6YB9dBv5X4iem42l8PWv9ro7P0cOuN7GWkQTOuqx+OIhUg6ODmEvruA+04Zb2mIXCjY71H+xUGML5xYDHfF11sxVrJAaAd0RJVcarCZTlQcwhrmu6JJczpAxkn/9TixC7NtI5l+ozkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 18:12:40 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Tue, 22 Oct 2024
 18:12:40 +0000
Message-ID: <201aca5b-fdbd-465f-b008-0f7c1ed10b60@intel.com>
Date: Tue, 22 Oct 2024 11:12:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
To: Dave Hansen <dave.hansen@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <88e77a00-ad62-4670-9d4e-a146bd8b420c@intel.com>
 <SJ1PR11MB60832636201CA40AD13C02C1FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7a902c13-bfdf-4319-9e31-81c199ecf65c@intel.com>
 <SJ1PR11MB6083E463572AC9E110A7199FFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <42d59ea5-5b36-49cd-b04a-4480064fff02@intel.com>
 <8489127b-1292-475d-b67a-b0fc868d8a4b@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <8489127b-1292-475d-b67a-b0fc868d8a4b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f9df08-5b5f-4423-cdf0-08dcf2c51dfd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHFWOUtPWExQclBFRnRwbS9ZcW1hallsOWRZZzNvcWlDNFNmMXBRVDB3SnJl?=
 =?utf-8?B?Rm42cExzN0ZnK3R5czlHck9kT3kzalY3bXh6akl3ZVlyZTFYVlRQVGowaGVj?=
 =?utf-8?B?YjNUd0VreDBHV2NvRmJFSXpJRUI3OE9KdzZrWW1XYmlib1FsQktXVzFObDVE?=
 =?utf-8?B?UEFsbzk0Mm44TUc5cGNXTFRLekNxVFhLWGJKUyt5RzVFWndDT1YwUGF6ZzBI?=
 =?utf-8?B?U3hHWDRwZVhaaTROcDY0M0tVUU1yN3F4YUJXemFZbnlRcmIrSzY1TWxiY3d1?=
 =?utf-8?B?eS92Q1NIdTJod1ovdjc1QWtmWTF0NW4yYVkzbW1ibzZDemtGMW4reDZuTTJw?=
 =?utf-8?B?TzVYVGdzdlEreWxyRUZNMmpQT0ZuM1JUQ09qSlA4bHBVWXRocUIwdHlsT3dP?=
 =?utf-8?B?bk5ONXV0bnJLM2x1UjFReWxwc0pvWDJHZ1hyYS9HZEcrdHUzdnRCZjR1ZmxG?=
 =?utf-8?B?YXhOUEhrWGUrNWdaNzNTc0g1YVF4enorYUVnc3FPdnBrUXp5VkJ6b2hyNmds?=
 =?utf-8?B?ZTUrMm9LSDE3dEFoUUlqc1NkNnNoOGk2WEh1czhYbW5xVTl6d1N0WSsxVUpF?=
 =?utf-8?B?RW1Ma0NtaTFKbkNoTXFKTGVER0pmbTlUTTRmMm9KT1NyKy9ycVoweWliVXFj?=
 =?utf-8?B?aU12aUlQYVVjaklPUGV1QUZUOUtTbFRVVFhodW9tWlZJNW02eGF3Z0R4V2Mz?=
 =?utf-8?B?N2U5NDQyZ2ZyVmFSWkMxSDJNSHIrOXQ3bitxUDZ2TDVvZkpYazlyNzE3R1Qr?=
 =?utf-8?B?eDhIRUluNGppZU14NjRGWXQ2UlhtMGRHZWNRbXNEdG1QcVUzdkM5YTRhODJu?=
 =?utf-8?B?dXFaZEpnNDRBU1NtNGlyL01pMjhicVFHMXhKck9tNnFCNFFqZ1haYkZFL3lx?=
 =?utf-8?B?Tmgvb3F4TGRwZGdVRlllMjRiQnZJV01hY1dCWkVnanpHQ0dhcjlTY3hMY3Z1?=
 =?utf-8?B?KzJ2VTdMZHp0OHlKSnhMbU1QNUs5YkkreWVnSXltdnFaaFFieWJyT3BvVmtW?=
 =?utf-8?B?ak5nZE1OSXJ1dkw4dGFrWWdhbmRKUGpGVGU1K1NpWDdTN0R1MHBHR016ZUdU?=
 =?utf-8?B?d3NTcU9xMk5wM1NkRWdEZGg4ejZuR2NURXRNTEVHNkNtSk5wbGU2VnB5Z1g5?=
 =?utf-8?B?K1EreWQzSXBhTm5XWnI1M2RRd2V0T3I5c2xaVjhqUlFFNTZjNDZGbytNY09s?=
 =?utf-8?B?SEdoVEwwRjJLVFQwUjJzMDJkSTMvc29PcFVhTThTTDNwK0J6S0locjR1Q3Jk?=
 =?utf-8?B?Y2hmUkVqbkw5YjZEOE1NcWlYNXliejJkUHAwRE1Tb0dJZGNYaDIzOXVuR0JR?=
 =?utf-8?B?OW1OaVdWL1FWcVJpSnVZdXhKNzI5UldyWDdEcXZKWEtkUzJxbmhqNzVCd2dU?=
 =?utf-8?B?VXFKTTdUdVFzV2hQVFE5VGFieEJGUTBFVndiOE9NU3RDa1FWL3VpU1lvK0J3?=
 =?utf-8?B?VU9lbzd6ZGdYSHFEbG5jSm12VkdtVW1ZYUFHRWtLbzMzY2VwYmtodDc2eDdr?=
 =?utf-8?B?dzlBNkdzeXlXdE1rcmd2em56M25PVEhxQ2VCOHBpMkZ5ZHlncWpWZ1dTK3V6?=
 =?utf-8?B?L0toMlpBOTRBbWJjalpaeDBzU0dBOTZweTJCeVBHOWRkN09jeXFLTHR0R1Nz?=
 =?utf-8?B?SjJPYWl0N05Za3JQRXJHUVluZ0lLYng3Yms0STkrTHNJcXBqeXE2REtFaFVv?=
 =?utf-8?B?SlZhSlZHU0JhUzhQekp0aGFNdGwrT09LWXVYQkVReWlDTmkyeWdQYStUanl6?=
 =?utf-8?Q?kYBbP58+P160uMU9cwmQJiMV3nhRiaGrIW9PQTf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFpiazhyeDJMNldlUXhjSCtCQXgyaDJXd0d0STRpanZURnIzbmtVUHBIUDR3?=
 =?utf-8?B?Q0VzSytQTFJhVzdpdVliaklTTmc1M21xMS8vano2OEZvVWQ5U1IwLzZFa1pG?=
 =?utf-8?B?ZjdMODhrbzViOGhPRTlJSWN6WUtpaEtsYk45cVMyQ0hFc2YzV3dsRXVMRmdw?=
 =?utf-8?B?ejk2SHh6UFlpZDFVR3FPOUhQT0QvWjluZ3h1RUExOFREVGY4Y2FHeWU2RUtU?=
 =?utf-8?B?M3dETTZBRjdXYXZjZHBKMTJ4REQ0SDFWZlBrRzBzTE9PZ2cyMnM5WGtQYU0w?=
 =?utf-8?B?RTZOTHJuZUVjN1k1VDV4NlpSa3hkaGh0NFVTNllZNG9XM21TaitzT3hBUTlR?=
 =?utf-8?B?SmY5RitVZHZZcmQyYk1SS0kweVMyeDJOM3RGYUlYM3JNMnk5RC9CVVZmT3hV?=
 =?utf-8?B?YmZGb3RnOUc3TVdRbDRaMURKNzZ5VU4rNzdGU004NjJmY0pMNHdDY3B4Z1Ju?=
 =?utf-8?B?Tk5oeWgzcldtb3JnRmsyQVVuRm03TDB1a290elJSWEhzVXBXcW9lMElIUUpL?=
 =?utf-8?B?L21TK1U5N1lCY1lJdjBKQWxBcGpQY1paeUNQVkNyTFdEQ1czNUFBNXQ5aGU2?=
 =?utf-8?B?a090anFiakhHemM4eUNEeUhuWGM0V3UvYTNIa2VZUmlNb3hXR0FtRjNWL2Rx?=
 =?utf-8?B?dzFWcGhGaytvYzE2OGdPbXc1c3d4SzMyVXJzUkNFbTZJTUZrNHRBNUhRVmhH?=
 =?utf-8?B?VlVWL3JTeWpJMUZnWDVlQ2t5b0gvNlRhMUJJNDF2UnFtV01xNkdtZHEzVS9j?=
 =?utf-8?B?VUdteDRBdnVKd0lEYmlhbjRVbjZ2SEZOZk9WNHNQZ3h1RXhGZ0pHUXRqRUdM?=
 =?utf-8?B?b3MyOEpQbGZNTm8wd1A4K0tPNW5sNVhubERXZ1lJZU1nNWxnRG10TnZNMWhl?=
 =?utf-8?B?TzJjeEdTc0xwc05hdy9YYXMyZ25CcFdZWnJGZGtpSmd2NDQ0Z2tNRjA2b0Jn?=
 =?utf-8?B?TGN6N3EwZjE2UDk1R25obEt5R25vcnpid2h3VnoveWhzVDUwM0ZTbExja3lF?=
 =?utf-8?B?dVlyYXY0L1E1UmhacmcwYzBBaTd5eGk5U2NNT0NxaWFOTlUrckNvTTFKRnlh?=
 =?utf-8?B?M1F3VzJ5THFhUWIxVEQ3aGQxcWFWbzZjS0tyTHdPcXp6Q1IrbmVXd3JvOWJG?=
 =?utf-8?B?c2s0T255bC9EWWhFUEdqQWNCUzdBWFRKWXk0VjE0cFBzSFplOE1jRkczc1NK?=
 =?utf-8?B?RGIrZEpMRi80Mjd3ZTRzNU5JNmZqS09kemhjblI5dDREclA2WE1RTXgyR1JQ?=
 =?utf-8?B?S0VjZWV4T1dQYlNZZlVTWm1hMUcrR0pES0h5SHBxYUxzaHY1cnFONm90cjFr?=
 =?utf-8?B?NUhwNGk3TG51MVRGLzA2UDBCM1pGVGttWmdDYlRQQUh0dGN1NnRmc3lXWHg2?=
 =?utf-8?B?bFNaend2TGc5T092aXRtNUJBdXk0dFR4bHBnSUtMQmpZdUtnLzRHOFNhM1RF?=
 =?utf-8?B?ZVFkc2pLSUlJbnRXc0R2NkIrRURsUDNTUGF4MW5uU3RUS1Q0K085Y0twMFAz?=
 =?utf-8?B?dGZ3ZTB2L2I5WmdaenlibkVEVXgzTW1kSmUxRDdNaW5nZzVsZTBCeTZSVWJ1?=
 =?utf-8?B?Y21vZUdheUdWcUhFcU8vT1NKZklXYWpBTmNLT2o0MnRnYmhTWHdFWlovYi9z?=
 =?utf-8?B?Qm1SbUVpU1NlSUNzWGxqUHdIdnlldVcxbkJKRWJJa3hQaTU4eTZKM29mK2Er?=
 =?utf-8?B?UmlBWlNjY08zYldqckpDWHBmZGs4ay9WNTBRMEh3eUlCN2RJU2dTSDZEc21S?=
 =?utf-8?B?MEd6andDbU9SSUNCMXJvalFYZ004bEJ0YnF5bHNrcUszVkpxTmYwb2tDV3hL?=
 =?utf-8?B?eHgxaHFvalhkekEyRWpMQmRIbDFKeFk5aVl3TE42NHhISzRwQVBJeHlXc2hT?=
 =?utf-8?B?a1BDUWcyakxWU0RTZXlzbTdqb1RSQWlPY3RITnV5QXIrTXVvdHJ1RVAxd0p6?=
 =?utf-8?B?WDNmM1hCYlVEb2liaFQ1TXVOdVp2MnQ4VC9YaFNUMHdOb2ZRdHJxMGUvSU9v?=
 =?utf-8?B?TnpCRUp6RFlHWTlVREJON1hMSHhxcnlSc3JKSC9wQWc2bVF5akFtS0lYNDYy?=
 =?utf-8?B?a1U4ZktBTlZxOFpuOWRWcHBwaWRDZEpsZ1k3TG0rNER1NjNHanFjajdvMFhr?=
 =?utf-8?Q?4daCvWV3WD/qaOVfAAmUBtTr6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f9df08-5b5f-4423-cdf0-08dcf2c51dfd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 18:12:40.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGz77mUIMHkmBC20lpGyQMqtcMYy0fA8thbpVt1LHWbNGAeK3guj+TXD1caEenLq+0XxAR07ylwkqNDh7IWgvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-OriginatorOrg: intel.com

On 10/21/2024 5:17 PM, Dave Hansen wrote:

> We only have a handful of these and they're mostly for early family 6
> things.  I bet there's less than half a dozen.
> 

You are right. There don't seem to be many unbounded model checks for
Intel family 6. I could only find 3.

early_init_intel() -> constant_tsc - Tony found out that it is harmless
since it got it's own enumeration later on.

should_io_be_busy() and acpi_processor_power_init_bm_check() also seem
to be for older platforms and probably no longer applicable. I'll reach
out to the power folks to confirm.

Maybe if we just add an upper bound to these checks then we don't to
worry about carrying them forward with the newer family 6 models and
upcoming family 19 models.

