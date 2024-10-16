Return-Path: <linux-edac+bounces-2109-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E369A10A6
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1BF1F21441
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF918660A;
	Wed, 16 Oct 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ky8ZbVcr"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B9D520;
	Wed, 16 Oct 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099855; cv=fail; b=b6sX45NvAiAiuDRvSkOqZ+mejgykU0DN+TBjrmMX+5KfkUD3Ru511GnL5Pi6LonKCa2vY+actr7yUvwQQnPbMPgBqW/nxWIlXIHxJuZMAZaTuz2isTrtMZdBXM/nWrwJzaEf8FksOghxfwHruTEn7JOFL8sSNOzM5DQXn7TO8S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099855; c=relaxed/simple;
	bh=+zSB3m9vDkpfmAzPm59twrNH4U3/bVOMLFRXC1TXZ+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HzlM4JsCYpfDCGR0CNRfMxy7CgGrU2yePKvvg6XQq0Vg/GHOIZTGTa8fJ+JqxNaP5CS2xCC3HhJEU0RQ04W3mVO+ZUQVNTi+/XPDSs4ETJDnkVrgideTf+YXV4Am7xbBlye+ICWCcZCu808QALKzLJVXPiBE0q1UTQCc1u2agCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ky8ZbVcr; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB7vWj8OUzJtFUoiu6y6f+6JtEb42Arw1SdX9WKa4JjjeHKdwa9owE6Shh2JrEy5KfP5GM+/IE23EODZtSV9Kmdx+p0qYTHKSwQJhZ76mxvXsAbj4IopYBUFFM6uIwu/p0BQ0LvwhY12A4nVFqjyFeGmFhgiY3LuQfnxTaEJ7/CcPb17TByYiOFKCRtEEk3Rmf9TVzo/wtsbTpUtbxMdeBVT7HkJED4JsvlqCACa7dxML18vS3yog+G7dgMkEdfePJLOC70x7/CAPuw81tuEZu63x/xENLxcyOUAfa5cFxxY+tnqJItLxE6l4qBSIDC6U6hz+GJYfD+7LwUZgL5hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zSB3m9vDkpfmAzPm59twrNH4U3/bVOMLFRXC1TXZ+U=;
 b=db+7X9o2Q7xXO0czUDOKPJ00t4RPudBLlgsqnR2DCGlSi9idEqOOFAYEQ7agTNkV1cZn6TgkclJ/dFPoRAYRwVx/R6Q7IxH9iT0VJtPuA0hV7bLCLN3l629Mzc1hTRzzevLfVe1HonQZQ6Al44yKplLQNOSCA2lnGiy9jieeN3ulEWZee5tIv1nMOX+9F5nz8GjeBUb46BcnPcOXhMKO1S8WYGz9HJnbbT3OGFLy9vJbf5YUgC51CPLxiQGnUSR89GZQaEHLd9ypDdEpJhTrqGevSZln85QrV6WTm/8UvX2+CiUZ0Db4qyG18ze9ysVCb0+W6wrE2bGJnOmQv1b0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zSB3m9vDkpfmAzPm59twrNH4U3/bVOMLFRXC1TXZ+U=;
 b=Ky8ZbVcrfExU745cSstelqtmxqeCvi/tBPe/0D7sF1Enod/f/ea29O+dCP4XAILUZGvOIoKUwGuLPuqBt340FSgRL9HVgPSplr77DkWxcSDqiMplDcm8ZnetOSqvu1D8hwsQ8FCgMg6+UU8TDDVhj2XRchApwP0wOWSonQ5MhGDPLY+qiIRZm7b50EmhDS0w1nnhAFgiWkijepzvqbMknoePz//QeqeMp+cYTEsRIr12mERrTG9uQIUur78UlumMeJ3nyHVd3VACAUI2aWAuVdeENetnK+HuQreLB2Z3gGg1yTWOfScVnNsE5cybiz57i8itHxpF48mmGgHjBucZcA==
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 17:30:50 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 17:30:49 +0000
From: David Thompson <davthompson@nvidia.com>
To: Borislav Petkov <bp@alien8.de>
CC: "tony.luck@intel.com" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Shravan Ramani <shravankr@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 RESEND] EDAC/bluefield - fix potential integer overflow
Thread-Topic: [PATCH v1 RESEND] EDAC/bluefield - fix potential integer
 overflow
Thread-Index: AQHbE0r+pSRv+mGsFk+OPQxgXDRXErKJsGqAgAAJiLA=
Date: Wed, 16 Oct 2024 17:30:49 +0000
Message-ID:
 <PH7PR12MB590228EA57AE7A66870E373FC7462@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20240930151056.10158-1-davthompson@nvidia.com>
 <20241016165027.GTZw_u0wpcd48VwbMA@fat_crate.local>
In-Reply-To: <20241016165027.GTZw_u0wpcd48VwbMA@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|MW4PR12MB6997:EE_
x-ms-office365-filtering-correlation-id: 02f6259e-4bb8-4ca4-a575-08dcee084713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZW80SG5jSWl0MFZCTnBOQ01GUGhFRTlGaWx5b3lDUEh0STA5VUpsRk1xSHk4?=
 =?utf-8?B?YVBhU2ZGaDZkRkp3UDRiYUhsa2EvT0FMbGZHWFkwaG4ybG1KZml6cFFWcWtk?=
 =?utf-8?B?UElFb1M1QTd4L2Z4dkw1eTNkMUFnaGxWbWhxa09VTEM0c1hSdDFFeFNQdmpC?=
 =?utf-8?B?aE45R1F4bkNyZEI2azJoSlY1WVdaaHp5TlZhRmZKMklwSkY2L2hlWkVTUHdS?=
 =?utf-8?B?SzIrbE90ODJJWkwxbFFWUVRrU3c3RGZITHg1WkswUWIvUCtwTkkrVzhVb0Mz?=
 =?utf-8?B?VEFYb2JvUE84UzdIZm0xRVRKNW1udHl2Z1lNc2x5anZmT0J1SmpXaSs5S0pN?=
 =?utf-8?B?R1Y2TjNMZzZKdExzZmh2Z3pWbXRKQ29tNmsxSHpvYXp5ZVliZU9rVS84Zm8r?=
 =?utf-8?B?NEJHbFo2WkxlcVF2cS9TN3BacndUSkdpVHdRTnM1TkkrbzlzZEFEeU8rUzYw?=
 =?utf-8?B?blNWTUgrenFMeXk3SUtwSHlWRFJ3eFRqMmhZR1NZY1NWQ0IrM2Rvb1BneVpX?=
 =?utf-8?B?cDAvTWliUHJ3SlE5TjdmcmRRalU2b0wvSlpRWUlXN3V2bFJYTWRSV1RXSGQ5?=
 =?utf-8?B?eFdYSzNHR3FiNVVXb0NTN21VWHI2TFZhaHB2U3JQZ3g0UHRIYi9Xd2oxUndH?=
 =?utf-8?B?a01YZEg4akdaUXlvd0hKa3dVRU1LMlJKaWlxTEVZQWg3aTNHZlR2RGs5T2ZT?=
 =?utf-8?B?RTlUQzBGZDUxdFhUQ2VUaEd3U3hsdE9rNFN6N1FkZEVNSURJQ2hRR25KblJo?=
 =?utf-8?B?MXYxL2hrWmpBTFovQU0yOGU0MFRjTmgyTDI5YUxVK1hYckNqZjlyL3NVMm03?=
 =?utf-8?B?NlM4aldiU2k3OGNyUEdsYzdpcVdCbU1vTzJvaWc4cEhhMVczdVNvMFllVzI1?=
 =?utf-8?B?bTU0N3VKOW8yYktWRU5TNHJkVHdKMHROcHJUKzhvN1FQUjh3ME5sVnkyMlNT?=
 =?utf-8?B?bk5lQjRFK2VwbS9WSnQxSGk0Ti9NVHNyenhJTTZ0ZU5ZQnJGc2VIYzRVYW9s?=
 =?utf-8?B?SHhSN2tiakVpQVpwZVFiVENyN0QyRzcrVkwyRW95RURFZGpGOWxmVEdLNXFs?=
 =?utf-8?B?N1dSbE9FWlNyWEs2bzlVbDVvUHg3eVk1aWNZODRsMmp4NzdMd1lzOEJqUHZp?=
 =?utf-8?B?VmxYRUFmcXdNSi84ekhPNGkxSGxIWnM4emhOMkZCMEcyanRwbmdvdnE4c0l1?=
 =?utf-8?B?ZkFHMHB4Tm1xZklHam55RkdsSWRRZHFjVHFKeFNvbmYyczRGMzJuTEdONUY1?=
 =?utf-8?B?a3U4UDlTQmVHWlRBSHVhV1ZIL3BLc051eTUwSmlBSkh3MmErRTNncjJrSEZp?=
 =?utf-8?B?N1NlcE9YZHZNT0YrMXdpb3NhcHZ5OXdkaXJkZk5hTHhsZWx4NndXK3J3VThi?=
 =?utf-8?B?TlZXSHlRYkZLRHBaOXYyNjFqb0Z5dFEwcUZDc3AwT0ROZDFjWEhrTlYwNjAx?=
 =?utf-8?B?Vkk0QWVFN2YycWpoREdjeXZLYXgrN295YnYxd3RtZnhNUFJuZVZ2LzVmdENr?=
 =?utf-8?B?YXBUWXJYTjg4VittNUR0VThzUFdiNXlJcWRYUWlkb0NtSVFNbHcwK3ZXclBU?=
 =?utf-8?B?ZlVSeVVkbHBCV1lPVERYQ2JBL1JDeWltZFhDU29WRDNIM2RHZlpieGRGWUJz?=
 =?utf-8?B?enRaSlBJRFFBZzdrZC9ZSjJUMEpEaXZPb0V3SnJHVkpleTZuT0M5V09IR0VI?=
 =?utf-8?B?cC9IcEVUU01hZ21lbGFyU3psdTQzUXl0eFZDaGRJcE9SZ2F1VUlvRlFKQ0dC?=
 =?utf-8?B?T2Y0d3MwVlN3eVRGQlJ2Q1FDbThnSmxHY2NxN2pnNTdyTnQ1YWZFWlNsak1r?=
 =?utf-8?B?RldZRVBUbTZXS1FJN0RLZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDVWZkovMzBFOTJOS3RwUEUrOVhvYzJ3RCtaYUZIZGlUWkFVRDJaRGVGWE5l?=
 =?utf-8?B?VzQ1RExiSC9nenkrRjFkZWRZR1lsL2R0bUhBR2c3R05WNU5hL1hQR1hBdmI0?=
 =?utf-8?B?eVhDKzMwRURmVkZqeFNadmNXTXZSRjBUK3N0aVpPUHU1M3IyZWhpMTBOWkhO?=
 =?utf-8?B?ZE4rRzFTSE9iMXNYd3Nsb0tXc0hFMGRrZGUvMy9HM0JRaElNSDZZaXMwT3FP?=
 =?utf-8?B?N1Bncm0vN0JZTkxSYU1LMUdyNE9nSkNlMGtHd3Yrb0J0VXIzRTBKMmVwMmUy?=
 =?utf-8?B?anNnTlY3MUhBOU9YN2N4NDREenZoZkhtQVgxRmVlL28zWGJ6OWVjbk9QSDVm?=
 =?utf-8?B?Q2NkdzFqcWsvWXA0V0pvbnVlOE9oaU5kWHdOcDNXS1h0N3ZyT3N5K1ZKLzJy?=
 =?utf-8?B?emtlRjBKS29xd1JzK2RTZXJ0QXhkekQ4cmYyb3Fyb3R1blY3a2ZreS9oMVVY?=
 =?utf-8?B?SGJGVEt6dWt5QWJSNDExNm1ydFFWeGIxZzY4bVl0bzVrcU53c0grTmR5Y014?=
 =?utf-8?B?VVVOYU5ENXBYcHY0RzRkeVhkT3Fsa2tZYUZLRzFscnhibHY0RmR6cVRReGtV?=
 =?utf-8?B?TGg2Szd5MXorWDMxcnRiWkFyNlJBS0Myam1kNzBBTFJKem9vVzJMUUNoVHY5?=
 =?utf-8?B?U2FNM3NnRjNiVGRBaW9DSVllR09lblJYRE1mdHlOOXRKeVFqWGhMVDZxaW5x?=
 =?utf-8?B?WU9CL0RlN09LMWZKN09OS0dKajNrSWZMSk9TMmltY1BZVFdrVEhhTmtmR0VH?=
 =?utf-8?B?MjlIVEoyMkp1Nm5qbExtd2R0bS9WblgrSWJScC80NWthaFd1U0d1bHBLS2I5?=
 =?utf-8?B?Skw1MDRKcm54TVlKa0VQbURpYllJemhmZFVYK0RJbDJ0d081YWQvMUFCY1Rq?=
 =?utf-8?B?KzR1V2YzOG85Z1VaUzNIOWVNbTZ0WERHQ1JYU29DRllub21wK1FTQmlNZVJo?=
 =?utf-8?B?SXhPelVuUkZoWjFEZVVtcWtpUU9HbTlHUEVoVUl1ZldhWGJKSTNieUtOV2ht?=
 =?utf-8?B?cTMwL0RXUVRDZEZlaVdjanR0eHJJRi9yVU1DYTcraVJCUEpzTTJKZ29aVXE2?=
 =?utf-8?B?R1ZBcWhlOGwxRzZkQ2tLV1c3QnJpWSt2b01GSjd5QWpYL2t5NEdDdUVVQkpK?=
 =?utf-8?B?d2RPTjBiVFdjNS9aSjNlWlRiSmJ2bGdiTVJGazdPV095ZGZUT1VTZDFkZlFp?=
 =?utf-8?B?U0I4NWhlRFc5SGdSNDJHZUJjY1MzMUJ3eWtYLzZhRjcwZWFETUtqeVJVRjRQ?=
 =?utf-8?B?dFRXdmNFRG5hMGRQV0pPQk5pZVNOOFo4U0t0RjNYeGVTVmxaVURTSWZkTEtS?=
 =?utf-8?B?c0dMT1doYXpWWDZ5TVUwSStrWVVkcmdSdDdlSmlVUzN2dzU1ZlZRb0dMRmU4?=
 =?utf-8?B?SVo3c0xiaVpYV3ZySkJXWFJ2ZUh1UFJzYW5BZUwzSTFaQ1liZEF1UHhkay8y?=
 =?utf-8?B?ZlU3ZUIzbDZhNk0xLzJ0b2JLenRNeEs0VkhMUTJZMmxHQjlzdThqRit6b2o3?=
 =?utf-8?B?Q3VwL2piMy9yblpldDFLeFpoWW9JR2RUbmMxaVpKckNMM1l2anV3c3BjUkVi?=
 =?utf-8?B?MmRZMC9GMEZVMEhTc2JnZldZa0FUU0s5U1dza1hkeU1QVjNCMmg1Mms5QzIz?=
 =?utf-8?B?dkZ1eGxHeFlQVjQ1ZElYTzVuZjhGRWlhK3kzWCtNYXlCQkdWaU9keksvV1Ey?=
 =?utf-8?B?dDdwZjB6Skl2VldnK0d1UzdPSE54WVV0a00yS1R1NG54dTdvb3YrMXcxdHc5?=
 =?utf-8?B?OG43WVI4WGQwQnBmeGh4blVDanF0cjZKQmVIb0wxL0dZRXNxZndWaXBpR29i?=
 =?utf-8?B?Y1hWajJUdjkzZ2wwd3NGVEVzdjFuKzE4c2N6ZVdXMVgzZW5QOHl1UlFZdkpZ?=
 =?utf-8?B?azlDYVppRWJZWTRQVW9IS2IyY2NXb2ErNUhTZkZ1VWtYNThEZ2NtMUZzKzR0?=
 =?utf-8?B?VWdOVURyMkF3d3FaVVZseHNuSDltc2ZRZUNIYXNYUGJEbW5HNWdoQlJoRHVK?=
 =?utf-8?B?cjBwT083dXd3d1psNjIycFpiNVpQcmFuSS9IanRmZ0JnUW16MmxLczVEbzVF?=
 =?utf-8?B?cnRwcXFVMFJ5NlZFNGQ5c2xRc1dtUFA3R213YnlKY3k0RUNmeG1RU0tZaHZ6?=
 =?utf-8?Q?JYLz1AszBjRsDUT8qhoAurIMp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f6259e-4bb8-4ca4-a575-08dcee084713
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 17:30:49.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02y7s4ugKTFEHlu/69H/3cC9AW3S3Y25TSlKKkPF+ndwEeqQ2x9S/FpMM0S/F5m9X5r7bw4HbNM2y5+C7LL4BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE2LCAyMDI0IDEyOjUwIFBN
DQo+IFRvOiBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT4NCj4gQ2M6IHRv
bnkubHVja0BpbnRlbC5jb207IGphbWVzLm1vcnNlQGFybS5jb207IG1jaGVoYWJAa2VybmVsLm9y
ZzsNCj4gcnJpY0BrZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgU2hyYXZh
biBSYW1hbmkNCj4gPHNocmF2YW5rckBudmlkaWEuY29tPjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIFJFU0VORF0gRURBQy9ibHVlZmllbGQg
LSBmaXggcG90ZW50aWFsIGludGVnZXIgb3ZlcmZsb3cNCj4gDQo+IE9uIE1vbiwgU2VwIDMwLCAy
MDI0IGF0IDExOjEwOjU2QU0gLTA0MDAsIERhdmlkIFRob21wc29uIHdyb3RlOg0KPiA+IFRoZSA2
NC1iaXQgYXJndW1lbnQgZm9yIHRoZSAiZ2V0IERJTU0gaW5mbyIgU01DIGNhbGwgY29uc2lzdHMg
b2YNCj4gPiAibWVtX2N0cmxfaWR4IiBsZWZ0LXNoaWZ0ZWQgMTYgYml0cyBhbmQgT1ItZWQgd2l0
aCBESU1NIGluZGV4Lg0KPiA+IFdpdGggIm1lbV9jdHJsX2lkeCIgZGVmaW5lZCBhcyAzMi1iaXRz
IHdpZGUgdGhlIGxlZnQtc2hpZnQgb3BlcmF0aW9uDQo+ID4gdHJ1bmNhdGVzIHRoZSB1cHBlciAx
NiBiaXRzIG9mIGluZm9ybWF0aW9uIGR1cmluZyB0aGUgY2FsY3VsYXRpb24gb2YNCj4gPiB0aGUg
U01DIGFyZ3VtZW50LiBUaGUgIm1lbV9jdHJsX2lkeCIgc3RhY2sgdmFyaWFibGUgbXVzdCBiZSBk
ZWZpbmVkIGFzDQo+ID4gNjQtYml0cyB3aWRlIHRvIHByZXZlbnQgYW55IHBvdGVudGlhbCBpbnRl
Z2VyIG92ZXJmbG93LCBpLmUuIGxvc3Mgb2YNCj4gPiBkYXRhIGZyb20gdXBwZXIgMTYgYml0cy4N
Cj4gPg0KPiA+IEZpeGVzOiA4MjQxM2U1NjJlYTYgKCJFREFDLCBtZWxsYW5veDogQWRkIEVDQyBz
dXBwb3J0IGZvciBCbHVlRmllbGQNCj4gPiBERFI0IikNCj4gPiBSZXZpZXdlZC1ieTogU2hyYXZh
biBLdW1hciBSYW1hbmkgPHNocmF2YW5rckBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2VkYWMvYmx1ZWZpZWxkX2VkYWMuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9lZGFjL2JsdWVmaWVsZF9lZGFjLmMNCj4gPiBiL2RyaXZlcnMvZWRhYy9ibHVlZmllbGRf
ZWRhYy5jIGluZGV4IDViMzE2NDU2MDY0OC4uMGU1MzljMTA3MzUxDQo+ID4gMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9lZGFjL2JsdWVmaWVsZF9lZGFjLmMNCj4gPiArKysgYi9kcml2ZXJzL2Vk
YWMvYmx1ZWZpZWxkX2VkYWMuYw0KPiA+IEBAIC0xODAsNyArMTgwLDcgQEAgc3RhdGljIHZvaWQg
Ymx1ZWZpZWxkX2VkYWNfY2hlY2soc3RydWN0DQo+ID4gbWVtX2N0bF9pbmZvICptY2kpICBzdGF0
aWMgdm9pZCBibHVlZmllbGRfZWRhY19pbml0X2RpbW1zKHN0cnVjdA0KPiA+IG1lbV9jdGxfaW5m
byAqbWNpKSAgew0KPiA+ICAJc3RydWN0IGJsdWVmaWVsZF9lZGFjX3ByaXYgKnByaXYgPSBtY2kt
PnB2dF9pbmZvOw0KPiA+IC0JaW50IG1lbV9jdHJsX2lkeCA9IG1jaS0+bWNfaWR4Ow0KPiA+ICsJ
dTY0IG1lbV9jdHJsX2lkeCA9IG1jaS0+bWNfaWR4Ow0KPiA+ICAJc3RydWN0IGRpbW1faW5mbyAq
ZGltbTsNCj4gPiAgCXU2NCBzbWNfaW5mbywgc21jX2FyZzsNCj4gPiAgCWludCBpc19lbXB0eSA9
IDEsIGk7DQo+ID4gLS0NCj4gDQo+IElzIHRoaXMgc29tZXRoaW5nIHlvdSdyZSBoaXR0aW5nIGlu
IHJlYWwgd29ya2xvYWRzIHNvIHRoYXQgaXQgbmVlZHMgdG8gZ28gdG8gc3RhYmxlIG9yDQo+IGlz
IGl0IHJhdGhlciBzb21ldGhpbmcgY2F1Z2h0IHRocm91Z2ggY29kZSByZXZpZXcgb3Igc28/DQo+
IA0KDQpIaSBCb3JpcywNCg0KVGhpcyBwYXRjaCBhZGRyZXNzZXMgYW4gaXNzdWUgdGhhdCB3YXMg
cmFpc2VkIGR1cmluZyBhIHNjYW4gYnkgQ292ZXJpdHkgKHN0YXRpYyBjb2RlIGFuYWx5emVyKS4N
CkkgZG9uJ3QgYmVsaWV2ZSB3ZSBoYXZlIGV2aWRlbmNlIHRoYXQgaXQgd2lsbCBiZSBoaXQgd2l0
aCByZWFsIHdvcmtsb2Fkcy4NCg0KUmVnYXJkcywgRGF2ZQ0KDQo+IFRoeC4NCj4gDQo+IC0tDQo+
IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5l
bC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=

