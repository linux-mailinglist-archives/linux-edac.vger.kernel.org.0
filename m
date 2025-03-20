Return-Path: <linux-edac+bounces-3392-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF0A6B196
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 00:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A40486639
	for <lists+linux-edac@lfdr.de>; Thu, 20 Mar 2025 23:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAAE22AE6B;
	Thu, 20 Mar 2025 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BJP2TfCS"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010008.outbound.protection.outlook.com [52.101.51.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98C22A81D;
	Thu, 20 Mar 2025 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513049; cv=fail; b=hF/TDcDYtxPCfLZp4ejN7RFg2J4XfimCtlJh5H5ZQ1vd7532nMuZwal2s4cN2WncO6u5HQZ+/jBzl3WMwEu7eZ/BB8xnNgEFxtZyUWuEi8Uu7SZi2YAqJ/C8T+L8Kivgpfoi6bqNt0hqPujGb70kSPjhyeUm9phzJlz/alRqhhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513049; c=relaxed/simple;
	bh=GjmV6+3V/al5OTZA+8dHYWIU2flgs5WkxeqVPkWlgLw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KR2ttxE2y0WISOJpS0erY/AfeeWeQDuYjnjUMMhzLHBAcYYr3kNDnQaeIQiBd1+f49Yclytkrg3VrCTL7ga1Gxo7GKhg3MPU8p+Fox1KbliB8P1RlCrA6qeQOQHZA/HvKTCQvIgYD9kVokfj3ZDaqUBiZnDE7XUO/UQIhJhAe7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BJP2TfCS; arc=fail smtp.client-ip=52.101.51.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc9jbl1tLCexOXKky+eXTzwF2BGoUnHxVKiF9XbIVt2xjgMcRfGaPe5cOlAlaBXMt1F1ucC1SaInFtCjtYnPW1NFbZ8rjD13AJT4S7wppELc9SFHUN89e6H1ECeYZAWmOVLmUKZ22z0uUuD1sOy2XHjuDdUQ0nc6eu50ApUJoaCCrrZjyjV3J0I9IA90qniLrtqRsNSHNmOIEGoFrYRJcE0XZ8lZZCdC2e1jxQ2Xt81c7SO8e9czDT72xNWPWzje2+pu+XOGm9llD+jbu2AVHNpUuUeyq0GdQzdDLY4qHQftiDW7erveIkGZ1ygpwyqG55t0C5TQciWANvKXOaovqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM5uIu46G12a9KPdLthrDMDQ6XRRyUos7qEUH9UBiGk=;
 b=ndlaIEYoh42henh6UEiRyFYojdw0FkCJzJPXXqLc6YLvsCWoLjcLVXfbDzRfVyw22YqpmKEYgnzCA2mzhcJTaWc9YeyDpEV9la632UKPH2DQWJf6CcnexDUIl0BX1XllveDzmckdT5KFCjxaGRXszEE8q6Bxb6oXeNaOJ3lcANNZA+4nxq2idlO4x2ja9wfRn6dGWuGURcoO7Uoba0UAYpoxuD9FqkBmlULZKMrpf6ah3eoYHeLWLIV+AJyqUx9nvBh39u01VAtAfPnvKzBoexbIkbG9ndmoCnZXPvxVVJO7gIYdHgRNMgx6xXeXhHngui2/0TrrneX9e/It54AVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM5uIu46G12a9KPdLthrDMDQ6XRRyUos7qEUH9UBiGk=;
 b=BJP2TfCSSVbZAsR4VJMEr5fzi/dUVRS9DUl+fI/oX32SgdaC1kNy8xM8ZMCSUPPl5PIJ4x2Wrno76Ld/thoA8DVHdwf27zBaum/8KBIp2qz+gNJC4vNniUwSP8PWE18EjnYjWZP8M1RrIj3fWLpPpS365vxU3E4oDAFGLFDOz6n95Eyr9xxk/NZbwhclDkODYA+kn7zmY/DYDs7pE+LRy2ElJEiriqPvor26gcY5nQZXrzKUASi9y6TFAWn3SvPItokiQGYG2IvdC96XhRwLwr8wCOokmDOa+GJSSSyq0BinyTucDrQMYU++7fnKhgO4VGBTt7fmD3hGLIZMb25hWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DS1PR03MB7869.namprd03.prod.outlook.com (2603:10b6:8:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:24:03 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 23:24:03 +0000
Message-ID: <3b325b3b-df64-4f16-9284-cddfaaa40a21@altera.com>
Date: Thu, 20 Mar 2025 16:24:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: agilex: Update eccmgr in DTSI to reflect
 hw/yaml
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
 <20250320164622.6971-4-matthew.gerlach@altera.com>
 <20250320193413.GB750632-robh@kernel.org>
Content-Language: en-US
From: "Gerlach, Matthew" <matthew.gerlach@altera.com>
In-Reply-To: <20250320193413.GB750632-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::20) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DS1PR03MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1ceb3a-3a2e-4306-4e63-08dd68064d76
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmVPSTdLTTl3cnRPS1hjenF6ZCtKZDg1c3pHMTltSUMyY3JWK3FQZ01qUEls?=
 =?utf-8?B?c2o1M3ZmSzFRUlVNcnlBODV6aTRUQ2ZBZndSQWcwUklFdEtvZDJUODduaFUz?=
 =?utf-8?B?S0M0d3pLUFArc3BOWUlGN3NuZkxNSTZJb2hCRGJheDhrK2pqSkFzK29yYTBS?=
 =?utf-8?B?US9ueC9XUy9jRklOSmh6eXF4OWNqUElhUWtieHFjaXllcFhpcWF5V0ZZRlRn?=
 =?utf-8?B?S242S3piMXh6enkrajVCR2w5WkJ5Wnc5WDMvTG1JNXlCelI2N3FmMjU4VzhX?=
 =?utf-8?B?eVJpL0NhSTRmUmswUzJJdlNoUTVpWVlBd3NZTTB5T3dtZmoybllmU3YySXc0?=
 =?utf-8?B?VDVEeVlBejA4MXd5OTNCRWdPWnJyQnFjY2VVMTlURkZjNnVMQWIrRHM3Mkx0?=
 =?utf-8?B?N2Rxa3RsYVA4RmI4UWoyNmRyb2VaL0x6MzhrSjlpWXoyN1RzQXVxQzN5ZzdK?=
 =?utf-8?B?MUdFOGRkWERyRVFjMVpZaUFaZ3BDbkJNMVpuc01xcDFqd2FEakZyWTJhT1Fm?=
 =?utf-8?B?N3NLYkxUOXgrMTUwNjhIVTFKcTZqYzFwelgrYk5FeEtmY05LYkt0TVo5RGV4?=
 =?utf-8?B?RWo0MUlkK3ppbmJYNnQzWUdYWDhYZnVyeWxhKzEwcG5oc1hFMG9RZm92aE9m?=
 =?utf-8?B?WFpWWUlXVnV4VHdLd1kwQWF1d3lxOGR2U0NoWkh2VFZIRU9XSmlOemNsTG9N?=
 =?utf-8?B?SW8vSWd5NGJqbUd3eC8yQW1lejVONXlkNEhmU1pGMnBQTjNEUktQYmhsZThu?=
 =?utf-8?B?cGJiem5FY3l5Q0RjTkEzaVMxMWRna1hPZGxRRDR3NDQ1Q1JhYzArcytTZW1t?=
 =?utf-8?B?eUIzNjN3ckx1UmxHalVZQjdXSmwrSXA5c3h3TzYxTWdPUk5RZHFOOUxyRUNY?=
 =?utf-8?B?OER5MFpEUzVFeDNKRS9QcHprYk9NQ2FSYXFJYlJ2eFN6SVpoOWhNNzBpNkJQ?=
 =?utf-8?B?MmNMY2cwdTJxcjBKOEIxVGlNMWlQeEV1eHZjL1RISUg0U0FmT0ZUcUplZ1JS?=
 =?utf-8?B?cnc0TnQycTJvRUxaWktlclgwR2VPdWswblEwZFBORGkydTBWMUpzSVFURHJk?=
 =?utf-8?B?WEllQUcyVUdBTVpWQUx3SnNzZzJPZTZiZzNpMjhmOFNxYXU5cmxoWWZyT3pP?=
 =?utf-8?B?amlNU2tLdThIWjd4QThJcWxwbnlBYzQ4VVp0Y25Ha1hFYkw4TXBSSUVxeGFs?=
 =?utf-8?B?VFFxWFc0NWNSb0Eyb0RXSHA3ZGlDSmZocUFNeHhKRUoxcjF6ZUF2WWlHN0sx?=
 =?utf-8?B?ODBucHMwNXJzc3JTeVluUy9LeWlUNnJLalB2bmJ0aVNITUtrdC9oZWJPbUVY?=
 =?utf-8?B?NThKOFJoeFY4VkNEVUFzMnhBUUZ6WFpmVGQ3QXhSejg4K3h2NS80MlFtN0Rt?=
 =?utf-8?B?YUd3ZU8zeVRaVzdid2pJemw2Qk0vL3pIdytqajRIOGJZSVB6SGlXVnJVcHV2?=
 =?utf-8?B?cmMyeWd1YmswbFdzbTd5Wkxia3o4R2dvdVhvR0pqWHpMd1c5T3MyYkVmQm1r?=
 =?utf-8?B?RVVpaFJsWDZiWk9qTGF4U0NQN0wrMi9uZmdEb2FJb2tDU2VRV0V5T0wxeWN0?=
 =?utf-8?B?cXpJWDEvWGExb1RmdnVJUUVYR0VVRlBYRmZJV1pMZHpJblNJbFdwRWk1dVdR?=
 =?utf-8?B?R3pOQ3hveEszdlMwUTJrUndjYlhoMXMwZjIyVnY4MmRMZ0tQYmxvWFF4Yk9v?=
 =?utf-8?B?K3ZCUDJFckNNMUhYR0pkL0p0VTlhR2FSRVo2N1BFaGxzTkpqVWU1V3VidzVJ?=
 =?utf-8?B?ZkFGUkFtc0FObUVYNTg3T0pheGc0WlhWdlAxOUlWbU9lYjRCUHQrT3pKelVz?=
 =?utf-8?B?dG51eE9BbnZpeEEvU2Jabmx4WGhkOVprSDJ3SUFkS1M1eXR5R3VmUWJyMzh1?=
 =?utf-8?Q?FITHbcLDFQZrW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUZRc3NNdFlNelJYWjFVS21HMzJQQm54eTVCU2ZWSTR1MnRhc2svNlhjS1ZU?=
 =?utf-8?B?RnhrVlJxMXhXN3J1ZUJFY3NyT0RDd0padlR4UkVnMW1WaFZ1dkdyNDZvclJw?=
 =?utf-8?B?cmFDQ21JNmxBOTdDb2drdC95dnVjTnlyRmlENy91NjZETGVnV2hDc1B4dFo1?=
 =?utf-8?B?ekovYlkxTjJDdjJ2MVVmRFUvc25SOVVmVEVleWtJQ29ielp5b1JuY29TUDVK?=
 =?utf-8?B?TjJrRWpiazhmbWJ2WVo0ZzgrS3ZzSGkyc3k3dGYydk91T1YrWGpEL2VtRTFM?=
 =?utf-8?B?aXVOcWdsS1IrV0FVOEFTYjJ2bDNJTnVyYng3MHBUKzBRaVhscC9sRDVQVWtv?=
 =?utf-8?B?MUNiK0lnMDRxQWNVdVJmc21IZ2VZUlNOTWpiQzJ2aXRXTXFqWFhpS0xNU0FK?=
 =?utf-8?B?QjNNUlJhSVVmV2R4SjJMczJRcUtGK3RIbTZWaXJkc2xiNEE4eGdGQTZjWVBC?=
 =?utf-8?B?NmFjNlNxM1B3SGdsU2ZlNDRHVGhud05sS0s4S1gwZXNYYmhKMDIrNEs3Kzlz?=
 =?utf-8?B?ME9Ud2NnQ1Vjdlp4bEJ6RmIyT3Z3MDhEOHpoRHRBVlFqbEpsQ1I1bFJQRENz?=
 =?utf-8?B?RVlPVGZyR0lwMFRhUzNRR2hSdUdoSno2aG50cGZBVldTdzl2Mjd1MUpKMFRF?=
 =?utf-8?B?cy9na0JtSnlKNDFscTJsV0Y5TGpHNVQ1cHViZmR2K2FvUXdxcWFrZkVHaDVq?=
 =?utf-8?B?Qk5tOE0xeGJCc3BvNExkTS94cWE3eUJhTWlrTVM3M0dmNE9ia1IxSmZxTlJm?=
 =?utf-8?B?bWlxTlkzSTZOVE03QUxpUVNySTFoamRPNlFkTEFGWTlEYVhqcnhyTTJ3dEZK?=
 =?utf-8?B?dmdyU1F3RFhhaDlhU0hJSXF6bUNBbzV5OFpHTnpiWXJMend2Ny9aeGlzYnRv?=
 =?utf-8?B?aUY5UEsvUXZRSkdPbVYxNHVVczZQY2Vyb0RqWHNOSzlldlhiaUFyVmdIWDRF?=
 =?utf-8?B?dGFpYU1xWExyZWJIVWd0aUZoZ0pXc2R2SzRXcWdtTjg0YUlUWW9OMkNsZVp4?=
 =?utf-8?B?TzF1ckdDWVYvRDdIOFlobDBRcjBNWkZESVBiOFc3RlkrOEhaK3lQZGpxOWlW?=
 =?utf-8?B?YmNyMDN0WlpieVB5TTQyaXBSQVphRmZpbnlmaGNsVXVNZ3ZQQWlzV1l4RWd6?=
 =?utf-8?B?dEt2UlZkR29ld05jSmxtNGZqUjM4SnkzeG12TXJhZU9ab2pKT2s3ZW1URG9z?=
 =?utf-8?B?cDUrRWRhMVVIc1VoUkNaeFFiVG1wUlBZTzF5dU1qSXplQzJlTCs4L1dOUXJM?=
 =?utf-8?B?SCtSd0xudXN3Y0EwVmtCL1VrSXhwdGZvRmNMZEFKMDk0MnlJeS8yV1VEdGFt?=
 =?utf-8?B?cTJqRTRubVNWSk9vVmxUSlFKaUdPSUpVdXZTSmtOdFBPZjJzOENUdjZUaDlI?=
 =?utf-8?B?b1hrRlVIYzFST1k0bkMvK0VHeFlBUkR5WjZsUVptdkQ0Q0hLYzlCUnhxeVFn?=
 =?utf-8?B?L1NodGhxbi9UQ0VodWhGUERTa0Roa3pUVEIzdTRxbjJPMGp3T3ViVElQNng2?=
 =?utf-8?B?RXlqUmNMV0VDMTVodEFiVHk3djdaTXZ2NWNOU3ZqYUt0b0V3Y2x1Sk9BcWF6?=
 =?utf-8?B?c0EzNUVydHJXUzJWc2ttcVF5RDU5MnplNlNKYUR3UVJlR0U5NHgxZzFpSHds?=
 =?utf-8?B?QlVIK0FBaFdmQ0YzeEJXUlFMWTdDbTQ2RkpyWXRubHBOQU5OUm9qeDY0UEVJ?=
 =?utf-8?B?WVQ0UjFHOUN3dDJvLzVPT0tBN25RVFRrazRZd0ZSYjJLSGExQzJhMm1ZcytZ?=
 =?utf-8?B?VGRSNmhITDlQNXlrVllCNG5mRmdOTzBjdWsxaDVCU1ZrWkxZcWl6UklJRDRo?=
 =?utf-8?B?b3ZVZk92b1hxUHVaMy9wMnMvc25LSGlhYVRPbEVCQ2d0THVUMnlQcUtod3A3?=
 =?utf-8?B?eFkzZ0NQcTkrcWFwa3kzaFZDV0pGa0xFNGpXT0NBNEdXTEV2aDRZWWZ3Znlk?=
 =?utf-8?B?cXRINndIOW4wYWNvcS8rc1FSckVCMkpneWQ2UXJZaXhmZ2lmVy84b0QyRTZ1?=
 =?utf-8?B?cWhTSDFibDU0SnQvejNLS2lNQzR5SkZhSmRDeEVYekpOSzJxWHFDNTRIdDQr?=
 =?utf-8?B?YzVvbFBSYmhaVERJeXdDd3Q0QmRROFlBcWdKUllxN3Z3TWdPcG1ncStCUlk4?=
 =?utf-8?B?T1crOS9oUVN2eVJ1YUlTNHd5WGprTC9Mdlh2dFJwRnFyaGVmWk5jMWNwdXFX?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1ceb3a-3a2e-4306-4e63-08dd68064d76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:24:03.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrfzZfjNJu8KcBKisQxyUUnJBQWmxMAey48lQPZVdU29a2wlc1lwglidrEQH0rS2I04GaRoYNcnLYGDY7e7KbWlM8Nu7N6m90fQTN2kB81Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7869


On 3/20/2025 12:34 PM, Rob Herring wrote:
> On Thu, Mar 20, 2025 at 09:46:21AM -0700, Matthew Gerlach wrote:
> > Update socfpga_agilex.dtsi to track the actual hardware description
> > provided in altr,socfpga-s10-ecc-manager.yaml.
> > 
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> > index 1235ba5a9865..708cb8e762b6 100644
> > --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> > +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> > @@ -602,8 +602,7 @@ sdr: sdr@f8011100 {
> >  		};
> >  
> >  		eccmgr {
> > -			compatible = "altr,socfpga-s10-ecc-manager",
> > -				     "altr,socfpga-a10-ecc-manager";
> > +			compatible = "altr,socfpga-s10-ecc-manager";
>
> You are breaking the ABI here. Before this series, the driver required
> altr,socfpga-a10-ecc-manager.
Yes, breaking the ABI required the change in PATCH 2/4, which is 
suboptimal.
>
> >  			altr,sysmgr-syscon = <&sysmgr>;
> >  			#address-cells = <1>;
> >  			#size-cells = <1>;
> > @@ -619,40 +618,35 @@ sdramedac {
> >  			};
> >  
> >  			ocram-ecc@ff8cc000 {
> > -				compatible = "altr,socfpga-s10-ocram-ecc",
> > -					     "altr,socfpga-a10-ocram-ecc";
> > +				compatible = "altr,socfpga-a10-ocram-ecc";
>
> AIUI, nothing used altr,socfpga-s10-ocram-ecc, so this change is okay I
> guess. Normally, we'd require both because there might be some
> difference you find later on, but here you could just look at the parent
> node compatible.
>
> If it were me, I'd just add the compatible string in the schema and
> avoid the .dts change. That would have been less work...
Less work sounds better. I will look at just creating the yaml, with no 
dtsi/dts and no driver changes.
>
> Rob


Thanks for the feedback,

Matthew Gerlach


