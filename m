Return-Path: <linux-edac+bounces-4594-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C41DB27091
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86737626F4A
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B52B25EFBF;
	Thu, 14 Aug 2025 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XXyYdoPS"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620F253B73;
	Thu, 14 Aug 2025 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205662; cv=fail; b=WmLzi6p/Fvl0d9Y/K0ifD01Od8g0H2yT5HXLWk5mdpzGH8lu9p96kxM14u0hLSq1TTy6YHnWfd31U0AloposjwUYF/JTXS6/hZBhBInrKKUj44x5Y8R5D7vfl2YwIyrL7lK5Wy3T3QfKU+MbAu36tNpK/tBuvRCY7U5pgD8Zv70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205662; c=relaxed/simple;
	bh=nvFHVNg/PPtQf7pQFI2AOOTwx18khztnzP9WvMYjim8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C6FKvW38ddk5Wqw8uUEwIsjs/Gfypic94DaqSxbbVqOOTLtVyhY+YkDmoqMB4xiYhCGAhCiaieupIIhzHTqdsegcs8S6liyM7Mb2iCRFtUZXfPQtNJ6zMIpKztZztGQMSH7SudZyVJY3YYXt9opgeYWcFEqPGCRD2JzWluWobWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XXyYdoPS; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNq6R8+H//79LwOzD8R+8DQ+x+zfPZNMy9TZgmWRdWFbAxr/eGJNP94cCjLAude9sD3UCBMEQwVNuWpfoqVH4lgrARJZ8hnTtCEvkiFKy+/CCtgM0EFvRltyMVmiuxiRSD+9qQ3qiarK0JsHlQJtih+1hHRUXdqvty8aAjDprR9duoptXIWTwGPBZfuSUdgXbYfIWSDA3fDtXqcp8lep9Gw8UVUPteyz1VIM/cKvJftoJUi59erwom5t9NJzMUkaF9NTUaftH3uDNu27/sY4wgSHbYJXzHTvOVhI0i067IDMey9sj0dbQETHX1+jxAMEb6quS/QzfJMLmhciRSJHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsP4wNTw7A1Hl9HquvyIyPzZrqPy/mhnToFMxQ9UHfQ=;
 b=cF+thQojVtYgBzSodbQCpPCsPb3ocaA9J0t9kMnn1I6/nbdcY2xXUWcM841DvTzf6bbjOCj/AVs7MWxkW5841nPGMjwnfN/syRch7jwXAVkjmB+d+VxKJy/S6l2Dv/lx6ELENG5oAIkEu82r+3g+z6AC2hpENLFL2jKntMXbAbD/7L4g7/FDtXdVGyqdEiwm/z0h0qGDV2qA32k5BPsIGtIgM10OGThhIvPrC19H1e48xbiyAPzgiGbwx/IGXilvnSD1gysMEe/Y1YP2mVShMyQPTk7Fxxb4CS+y0gMLHq0Tt7+Y1yekdY4Sdjulik5bzLfNdMbyXQsYDI8CfJ7otA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsP4wNTw7A1Hl9HquvyIyPzZrqPy/mhnToFMxQ9UHfQ=;
 b=XXyYdoPSo4KKbHoE+fZv2KxuhVExcOGy7tANzlUoWjShk1yKwUlVrugdfwrLfOlXAYGgUfjlfUvM3a2rzG9f/nZhfJFyFRasK851f6M7j3tGlB/jgPxKBfgYsv2389gCQ0hf4Vd7zNhRCqAwdfdavLVpvOB1W7YmBHCnPGO4gs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 21:07:39 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 21:07:39 +0000
Date: Thu, 14 Aug 2025 17:07:30 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2] x86/mce: Do away with unnecessary context quirks
Message-ID: <20250814210730.GA228071@yaz-khff2.amd.com>
References: <20250814154809.165916-1-yazen.ghannam@amd.com>
 <aJ4U3g4fDNNibUOz@agluck-desk3>
 <20250814193056.GA192444@yaz-khff2.amd.com>
 <aJ4-c0gNPbwwU3jk@agluck-desk3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ4-c0gNPbwwU3jk@agluck-desk3>
X-ClientProxiedBy: BN9PR03CA0741.namprd03.prod.outlook.com
 (2603:10b6:408:110::26) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b7ec67-c379-42ae-564c-08dddb7699bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUw4cEJzL25wdVlERkRLT0VpS05TL0JoVEhhT3VnMjNuUUtxby9JZDErVktX?=
 =?utf-8?B?WCs1NEptR2JxdkFNUnF0RHlyRTc0Tm1ZbkVtUis2c0ZJeWxWMmNFVm14czEy?=
 =?utf-8?B?SFBIZUkzc21PZE8xQTVRNFBFN201UFpjcjFkZ0lsaDN2dzd3d2w0SlJMMS9s?=
 =?utf-8?B?TGtzNkI4TWJWOXRaYXNWZDdEa2k3bGdSTUxSY0ZNcE5jZU9EUS8xVStYYmNu?=
 =?utf-8?B?UU9PNWJYMmcxQktGTmQ0T3RtRUc3Wi9vekhYbEl5Z2x1ZFphdzRIb2tvUmlL?=
 =?utf-8?B?UmJ3M283bEpIeDRvbVprdlpwdHBxMmhmckFQb0NqWlVxQkhmV01SeElHZVhL?=
 =?utf-8?B?amRGcVlOVFZPUm1hQTFRT212dFFkRVNQY2tJeTdDRDJSUVIwdGFyRXBMQzF2?=
 =?utf-8?B?UVFnMDlLZnJHYmtKQis0ekdrM3FLK1d6eXgrL3NENWVrZTdNTjhNbldSdzE2?=
 =?utf-8?B?NjFISElOa3NnV2tqUGo5VVI1RnZTVnRpN0s1TUtKVkp1bXN2aUttcTZCdmpO?=
 =?utf-8?B?YUF0dUdrNlR0QjU2NHViMUVPMXpnTzJPUkVHQ25yUDE0S21vZmpQSFNoU3Ex?=
 =?utf-8?B?QW9xS25sTlZNcUtJK3Yza09FLy9sS1dyMHYybXhFbVQ2d2RrTDFxUnlBbDhx?=
 =?utf-8?B?aHBFRGtyUm5xd2h4VEJsQnc0bzZkTzljTHE3UkhERm8yL3NwcC96U2hWYzZY?=
 =?utf-8?B?ZnVaVnViYVlHL1UxR3VRSEEzTEZmQmVXb3UzRzFNUFlwMVNkU3JYTXBmSlJx?=
 =?utf-8?B?UlkzTFYzLzdPRDZHRGZKNlF0cllIdDc3dVFZNkUvSzN6QnFBMm9QanhBb1hV?=
 =?utf-8?B?aXNCZjZWSy9GcmM1a2I5aktjMFBsbHB6SXhCbjl6ais4cFhFZ2N4RExoVDBu?=
 =?utf-8?B?QWQwa1p5Y3JTaFA2M2RxSlp6NkowYWJCZW84TDVGb295SVRwQ0ZtcXhqNktI?=
 =?utf-8?B?V1d0Q3V2YitBVnRVeDNVTHk2S0lyMUEzODMvV3gySjFHdm9nUzBFUVc4VDk4?=
 =?utf-8?B?TEtuZlB6RUNFaWdVMFpzNWJZOW1rMEV4azRFRUsycmcyaE40bWVnNEJlT1VJ?=
 =?utf-8?B?VXdBUTRpWFpEbnErV3FTT0h3Q3hMM1pCLzkxVlVZT1ZidGUwcVJCMWt2Q1or?=
 =?utf-8?B?WmJDdVJ3Zyt4eUEraXFMd0VPakJaVnlQNkttWUl2SXZ1N0VrMEw5a21id284?=
 =?utf-8?B?cjlNZy9HVy9mbXJsWXdyeGJCdjllRDZRUFl4QksvNmNYemFyN20yOTJjc3JN?=
 =?utf-8?B?dFN0VW1WZDFqdE9Eb0diVy8rbFJhWUtsUERCOGlwUHQ4L2lSTHFkOTFDSWN2?=
 =?utf-8?B?NW9tUXBGZWJMQk1zb3N6RXZFQlg5dHhDUjl4QWlYRU84ejJ0L1FZV1JwaEgx?=
 =?utf-8?B?ZDhRSlVnRlU4VGhEb2FGQUVCTnZYV2F3YzNVS21FcFlCNlF6MElmVUVYd2F1?=
 =?utf-8?B?cXdGR1hDUWdCNUR4UDVKSTdYbkVENGsvdDU4Tks4UVFKYlQ1K2N4bXNoZDZq?=
 =?utf-8?B?cXVXY3pFcTJVbkhvVkdBVFpMMXpMTXcvZGprMy8rZUwvRWxHeTAwRENtREQr?=
 =?utf-8?B?SkJCUUVrRUpzaE9mRzArQjJFRnN1TzF5ZGNDa3Zjemo4VklBd1BmRkdsd3FF?=
 =?utf-8?B?WndVZ292SWZRK3EwRmhyWFJFeDhVUWgzdjFsNGFkZnRkTEhlR2c1Yy9UOHY2?=
 =?utf-8?B?R3VvWjdNZVlTSW9nNk5ldDJ1Q0ZhWkt3UXBMamh6Y2JaLzZ2MytPUTA3L0lx?=
 =?utf-8?B?citGR20rUERPWjcyWjVDRmZPQUY3aTR4dFBHdXFHUnAvbVl6RjB5QlVjMXJV?=
 =?utf-8?B?NHJyc0g5K2kxcTFGQlhCY2owZ1pLR21Yc05qN3ZyZU5RSTZldXYrZnpwOVFy?=
 =?utf-8?B?a3ppYmhjM2xMSjZmV0lrcksxeTZKZGlZY1Q4R21RRThVY3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZJbVRhbUxsamN4dFg3SlZWV1JlTUNTRmVKb3cwdU96TVFDSWJ6c1dDZUZZ?=
 =?utf-8?B?WVExQ2wyYUl3OGhYMzZYdjh4VFZJMHNGUm1nNWNUaGEwVExEMTJzUXVWUEY2?=
 =?utf-8?B?ODhFaHUvZk96V0c2TmRVKy96SzdnVW4vNUxTWXdFQThXa29qVnFaVFcvdkFr?=
 =?utf-8?B?emJwKzRPSlFRTUhqdjFFYU1hZ1AyS3o5OUorMjNzNTVkVVpza1dIZUZKRTEw?=
 =?utf-8?B?eXk5MWxiaHRIVFBhaTFWWm9IZHhqTWorb2FiTzF0THZoaVI1dVdERXkzOFRK?=
 =?utf-8?B?ajEvWFBSTzJpdit2RWl3cWhCSzFIekkwTG1lRFg0RGJyc0gxZUcyNDlTbnhF?=
 =?utf-8?B?dFQrbEhEVVVrZkZhSC81TEx5VXVtZnkreUZBOXoxOHJ5a1VDME9sOExEbjI5?=
 =?utf-8?B?dWdrTWJJb2Q1M0JldEpqc1V2Q0Rsb0RIQUlKZUFuWVRlVkt1bUhZbmNlYjls?=
 =?utf-8?B?REhLQnFwRjQ4SmlSZUFIemprMkEwR1g4TllLMTVzeFptMC8vMVZPa1kwRHBU?=
 =?utf-8?B?OUJsa00xQVRMOG1uVUVXdzYvSkc2d2FxTXd2blY4bE1UaitaMkNyY1hsQ0p0?=
 =?utf-8?B?YUNLL212MHBqT0dOeGlpUXo3V29adDBlR3RvdEhhdkEyTmZGZ1dZYzRsWjRp?=
 =?utf-8?B?THVHZzI0blQwbFhXdTR2NTBsYU00aVBjMFUrL1Z6ZUlmU0tVWmY4eGxOSjZm?=
 =?utf-8?B?ZVVhdDZkZ2kvK2ZWOW5nc041aTNpaWpzdzlkbzFiK3cyT1ZYOWxlR2svekxW?=
 =?utf-8?B?V0xuUnNhL0RVdGp2alZKZGNkOHI4NXZtYWhqQzF3aTRxaVJEb3FvUEFmWE52?=
 =?utf-8?B?bGRRUVV4djVjZGFGcFA1N045ZFZKZjVPNnE3RXMyV3FvZE9iempMdEtjay9F?=
 =?utf-8?B?R1lJdmtoWkoxQm1sM0xlSC8vR0s1ZUlQWmxQclpweG80bzY1MG9VWWxZeFh1?=
 =?utf-8?B?aDZWOWNTZHFjdXNBVE05dW9sRExBNHRLcjZFU3UxditITkFiMUZ2SEZmZGRL?=
 =?utf-8?B?ZWQzWFJYV0QrNFg0b1pSd2ZFdlN5bDRZZ2MxL2xxRnRXVzB2OXBUMHNCZXBK?=
 =?utf-8?B?Nk1ZUnp5UDdkWlV5TjFBY2JpMTFWM0JjMUVSSG5MZWN4c2Y5OGNXMkF2TTFY?=
 =?utf-8?B?MU9SdUZKTkhqZjJQL1gwaFMvakJ0OExVczNLcXJsd2krS3lWRU41Y0x0MG9N?=
 =?utf-8?B?amg1SmN1M0dUR1BzMzRRdUhuaVNZK0YxNWxXOGJ6bkRDZStsTzFEdFgxakVk?=
 =?utf-8?B?ZGNGZDQ3aHQwcFlRcnJsSHdGNVZpZ0p3RmlTV24rN1lxRzl6MUVJSmNpWTV2?=
 =?utf-8?B?NFFoOUxwTlZSMVN1ZEllQnhGSUxEeEVmNWxWakRLcEordk1mdFpZcFdkRUtJ?=
 =?utf-8?B?aGY1UklucXlzM05OTHJWZE1KYVhRUzZBTDZ0L0JKTngzSGx3L01KL3dvTTdn?=
 =?utf-8?B?anJObHB1MFNYY0d0b0NuNmVEeWkrdjl3NTRUYnlhWU5CM1RHRWxZOExZVllD?=
 =?utf-8?B?UVJxb0J3dkFQNUVMa1hJeFZrTmR2ejVwZnJVa0NQa3o5Q2F4RUdLR2RkQ3ZV?=
 =?utf-8?B?MEVSbkpzYWtQNTA4ei85OG1aMmM3VVMwQ3B4ZStCMDE4TjFxN1JjWHBWaktu?=
 =?utf-8?B?TURGSURpaWlRLzREUW1JMXdYdWdGbEQ3d0I5WXQ5OFV1TW5kU281bDJhU0VJ?=
 =?utf-8?B?M2ZZdFU3UEIrMkNiWXNYdHUrODRmcDg0RnI3T0oxQ3daVDRzbzNONXloTS9W?=
 =?utf-8?B?c2duTjdLeUE4a2Z6OFFudy9zbGh3NTRrRVhGaGhGWnhrTGtWQlpCbzN0VDht?=
 =?utf-8?B?MlUwNll2ZlpJVDd4Y2JmdVNSWEMwd1cwcTB6a3Y5OVpCMER3MmkvOEFKdUlY?=
 =?utf-8?B?cHl5WFBZZlRldTZJRnVHbWNsM2lVVW4xblpOOWRtQmVHMElSaG1mekxnbS9v?=
 =?utf-8?B?WWhhY2JEZW1sQ2c1L2V4UmpacU1pS0dFZG54bll0N0wveEVPZnNEOFJFczVv?=
 =?utf-8?B?MURucnBpVTNYLzk1MmdVVGpwK2VKbFF2dGhjaGVSTklQZjR4Y2V2Y3Q5cXlJ?=
 =?utf-8?B?NUhkNXk4K20rR3ZjTHJPalFCVVorcEVFRllndlhLMjdHby9YNCtuTjN0MXFY?=
 =?utf-8?Q?bMLyQ+1DKCs55hCEftDao2p5g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b7ec67-c379-42ae-564c-08dddb7699bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 21:07:39.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVwXKxcKzbGGbmtpWTydG8zRkT9AKSSg5ld6wIfjcmq1RtyEapNWf7U9IxW5+IgWVdLFL2Fp7lO7pthmtn1z+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01

On Thu, Aug 14, 2025 at 12:52:19PM -0700, Luck, Tony wrote:
> On Thu, Aug 14, 2025 at 03:30:56PM -0400, Yazen Ghannam wrote:
> > On Thu, Aug 14, 2025 at 09:54:54AM -0700, Luck, Tony wrote:
> > > On Thu, Aug 14, 2025 at 11:48:09AM -0400, Yazen Ghannam wrote:
> > > > -/*
> > > > - * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
> > > > - * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
> > > > - * Vol 3B Table 15-20). But this confuses both the code that determines
> > > > - * whether the machine check occurred in kernel or user mode, and also
> > > > - * the severity assessment code. Pretend that EIPV was set, and take the
> > > > - * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
> > > > - */
> > > > -static __always_inline void
> > > > -quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
> > > > -{
> > > > -	if (bank != 0)
> > > > -		return;
> > > > -	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
> > > > -		return;
> > > > -	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
> > > > -		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
> > > > -			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
> > > > -			  MCACOD)) !=
> > > > -			 (MCI_STATUS_UC|MCI_STATUS_EN|
> > > > -			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
> > > > -			  MCI_STATUS_AR|MCACOD_INSTR))
> > > > -		return;
> > > > -
> > > > -	m->mcgstatus |= MCG_STATUS_EIPV;
> > > 
> > > I don't think this part of the Sandybridge quirk is covered in your
> > > new code. Without EIPV set, the Intel severity table driven code will
> > > fail to note this as recoverable.
> > > 
> > 
> > Which severity do you mean? EIPV is not needed to be set in any of them.
> > 
> > Unless you mean this check:
> > 
> > 	if (!mc_recoverable(m->mcgstatus))
> > 		return IN_KERNEL;
> > 
> > This would never give the "IN_KERNEL_RECOV" context.
> > 
> > And this is the only case affected:
> > "Action required: data load in error recoverable area of kernel"
> > 
> > But that is for "Data": MCACOD_DATA
> > 
> > And the quirk is for "Instructions": MCACOD_INSTR
> > 
> > So I *think* we're covered.
> > 
> > I got the impression that setting EIPV in the quirk was to fake our way
> > through getting the CS register. It seemed to me that it wasn't directly
> > needed for severity grading in the quirky case.
> > 
> > If we unconditionally get the CS register, then we no longer need to
> > fake EIPV. At least, that is my understanding.
>  
> Yazen,
> 
> It's horribly subtle.  On Sandybridge machine check bank 0 is shared by
> the two hyperthreads on a core, and machine checks are always broadcast.
> 
> For instruction poison consumption both threads on the core see the
> machine check and the same IA32_MC0_STATUS value.
> 
> IA32_MCG_STATUS is per-thread.
> 
> The thread that tried to consume the poison sees: RIPV=0, EIPV=0, MCIP=1
> 
> The innocent bystander thread sees: RIPV=1, EIPV=0, MCIP=1
> 
> The innocent bystander matches this entry in the severity table:
> 
>         MCESEV(
>                 KEEP, "Action required but unaffected thread is continuable",
>                 SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR, MCI_UC_SAR|MCI_ADDR),
>                 MCGMASK(MCG_STATUS_RIPV|MCG_STATUS_EIPV, MCG_STATUS_RIPV)
>                 ),
> 
> I need the consuming thread to match this one:
> 
>         MCESEV(
>                 AR, "Action required: instruction fetch error in a user process",
>                 SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
>                 USER
>                 ),
> 
> 
> But the first match nature of the table means that this rule hits
> (becauase neither or RIPV or EIPV is set):
> 
>         /* Neither return not error IP -- no chance to recover -> PANIC */
>         MCESEV(
>                 PANIC, "Neither restart nor error IP",
>                 EXCP, MCGMASK(MCG_STATUS_RIPV|MCG_STATUS_EIPV, 0)
>                 ),
> 

Thanks Tony. I see what you mean.

Do we really need this rule? It is essentially the same as the following
rule:

	        MCESEV(
			PANIC, "In kernel and no restart IP",
		        EXCP, KERNEL, MCGMASK(MCG_STATUS_RIPV, 0)
			),

...since we assume "KERNEL" context if RIPV|EIPV are clear after
checking the CS register.

The message is not as explicit though. 

I did have an earlier idea that we introduce an "UNKNOWN" context for
the !pt_regs case.

We could add the "UNKNOWN" context to the "Neither restart nor error IP"
rule. That way it'll be skipped if we have a "USER" context and then it
should match the one you want.

Also, I just saw this in the Intel SDM:

"For the P6 family processors, if the EIPV flag in the MCG_STATUS MSR is
set, the saved contents of CS and EIP registers are directly associated
with the error that caused the machine-check exception to be generated;
if the flag is clear, the saved instruction pointer may not be associated
with the error (see Section 17.3.1.2, “IA32_MCG_STATUS MSR”)."

But I can't tell if this is true just for P6 or all, because the CS
register isn't referenced again with EIPV.

Thanks,
Yazen

