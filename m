Return-Path: <linux-edac+bounces-4041-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E6AC80C2
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9167A25DCC
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50F21CC64;
	Thu, 29 May 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MbpBe7RZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11011067.outbound.protection.outlook.com [40.93.199.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD891362;
	Thu, 29 May 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535447; cv=fail; b=IejulrcmYFXtZoDB4H78ghYxAqGODPD8Wl0nmSuSXaVlFcy9XVSK6309U1xGm3mRmZxKbomCcjdOg4/l6DL9kFpg2nJH2AvYAUW9RkLJqz4zPS3A4X8htXH2U+GADC/FnkQh5H/4Wa0eD7dopvfyZYr02hfy4G28GjCYfE6LVRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535447; c=relaxed/simple;
	bh=fabWFHvFGEUriksz4v1aTmxZ0o5fiQhY7UruCpBynmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UdY4N0BllMbrn5m1Lk8CKpGbbKHTwRRcF2Z7l2P6IiNrqVoYKxs1vYSu74Ve1t8SnxX+VXm3aPrSWR9wyNLIfWYnBx01oRd4yyMuDnEwY8jMtDrz5ziv3IpuCvljmDRhVVbaUT+DbLsTaAZFhEYay8OzUmb9LETwfKTRPfaYZoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MbpBe7RZ; arc=fail smtp.client-ip=40.93.199.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKQV74A7/LH1J8EDA/afgNzuz+RH1UD1BpdavOC4To94w5uuTl4D6M8tvhiS7omRw579tZ/PsidglyJ6Pe7PCW1RJ9vVRkQY1M1/4r50cMzoBTm3B1KYru624u5G6SusHm/T7PpSwDamrwo2Lz3zvdYRLNrdx4SmaMptD/AqQ4/e9iULTkY/NH15OM6jM4rr2CiZw8hlWef+Jf/il6GiCiUGvtvhfq5IgL0D6cumToV5ssz1bA+fb5KmHoAZxmmVR+kaUU+BzsKFcVH/unkiXn7Pi0xWGxupoRhCVO23F5V8edi3Opp58ElCiVaIE0aK1F59f+6sSZlBscJ2q39lwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdScPbuqoSeY8u8UsA9Ef/bFzXvzDLabyEt8CqkF2Gw=;
 b=u5TvBCDlQPUB41jbV0jbSyACMjCGwHrutW6o8HB4VLMBGqLmP/oMdJz9Mejb6plJdMumd7xwwUdZbIvwOx7kn1Utt5lRuP7QjEzY7sHC941AMy0r/1/ZCV3xtniLyXWmfJR+MsxYSR6m3RWgQLksWq3GKkVO9VD/4iUG697HyZSyL54Z6zTC4BHqmf0cSMwDNCz0Ly02Nq8/PbMVTC9b6ZVNgEDzE/aVTyO6kWwfTrwsdaLRforoukDTa7F+RJDDtUF4yuRVnV6GsYbkRGN2lZxLz3y9TvYb/DCUmdXzHX1j2DJ4Z6w5FKGxSA3WNiSYkiAMLDGW1JJys+JHZ33+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdScPbuqoSeY8u8UsA9Ef/bFzXvzDLabyEt8CqkF2Gw=;
 b=MbpBe7RZoW5f7ju8re2ya8cUbNiHcEYmD8NaxUEh434lxp2RHMPTiVNzBh2h39WTqCtnIqXa8TiGYDf1NY3AdtJqibY0CjGJYHYNmdZfKCK38+7sGVzDK/tEJq8t71PN54koaJ9OiKululiKyA1GKL8eUSmOiwJMGHZB7H+coDJj1S2zNA6TbfU0V41bJGRzaDhQjZfYu3SRILRFtT/BVRKlbIu4GI7eRoY+MkGp8Nc8+wMrV/bDQUJTr1zK/3RQO+C2DfLZTcHbua89vAjEhz2zYS6T38HYl28ntWRIHXqOcY0D9w/B6QLDHmQUrIhtXR3YotaGd97i8OehBgYF0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA0PR03MB5515.namprd03.prod.outlook.com (2603:10b6:806:b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 29 May
 2025 16:17:23 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%4]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:17:23 +0000
Message-ID: <ebff3706-9c8d-4545-952c-af6a8b31472b@altera.com>
Date: Thu, 29 May 2025 09:17:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/altera: Use correct width with writes to INTTEST
 register.
To: Borislav Petkov <bp@alien8.de>
Cc: dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, tthayer@opensource.altera.com,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, stable@kernel.org
References: <20250527145707.25458-1-matthew.gerlach@altera.com>
 <20250529154146.GDaDiAOlkiHTwlgE0L@fat_crate.local>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250529154146.GDaDiAOlkiHTwlgE0L@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA0PR03MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: fd64298f-d4b6-4d06-a053-08dd9ecc4b0d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzZHalJLRGZ6cDRwNWRLczZ1MGN6VVpEZUQvZUhnVmNlbFptNzdoMkY5Z25n?=
 =?utf-8?B?SEpzVEZGVFZkTTAwNXVIWWdwN0ErSXM0VzQ5TjdSa2JNcUh4WnlBdUIrcE91?=
 =?utf-8?B?UTczRUthZTlralp6cy9ubHh5enVpbVFwV2hiZWlWNHZseUJqRDZTeVd4YUtq?=
 =?utf-8?B?dFFQdHplVlVGTWUvOGVKVjhIclN3L2E2bHNnN3BzdjdYcnlWOEI0WHNOWGpC?=
 =?utf-8?B?M3FuRGYvSEtTY1AvMkJYampXZHFja3o0c2VIdDBQR2ExU1hqQ2tJV3Y5Vzdu?=
 =?utf-8?B?dTllUllzbmwwckFsM2hGZlQ0ODl5S1Z6ekh1Q0s0Rnl1a1BFTDJDbk9IdUoy?=
 =?utf-8?B?SDhOcHk4THhTR09URTV6bnlZb0lweERwczhaY3ZQU2k5TG1uTHR5c3JMenNJ?=
 =?utf-8?B?ZkRKTHNzM2ExTUxuZlU0enA0eEFlSkl5RWtIc1dpc295Nk1xdXhNVTdkRkhi?=
 =?utf-8?B?Y1JRNnplSENkV0ZsMXNPRjhadll2dGI4K0pWMk81Ymk5VmljREp6aEUxOHYx?=
 =?utf-8?B?cjhqTDlraVVqQUMySUE5TjloNG1zbm9STkp6V0dERjZjMSt5OTkwdi95QnpC?=
 =?utf-8?B?WFBKVWh0bFI0WEwyQmYrUTYxSjVjenVvOXJjZjJ4L3dMQzdOZnVNMlNjRVg1?=
 =?utf-8?B?SWpJZzFYemJEOHdKY1h3dS9HTHE2MlRzUkRhelhSK3V2aHFBQjNrZUo0YmEy?=
 =?utf-8?B?N1ltSWJVbXhTU0toQ01PbXJmWDN0T1pBTzFhdkRkZkt6Y09OMUhvMEYyYVhO?=
 =?utf-8?B?Mm5BalZlZTFrek1jemFZNElsbFpNZVROZ24wTDlhK0ozaVh0Q2EyUnVVMGJS?=
 =?utf-8?B?aVVBRDdwTWFRdUJkVHpMVHBvQmFtQWgxS2xZZVpDUE8zVGhIODBxUjNzbUUw?=
 =?utf-8?B?dFJCa0lnVFFLYVZSTEFVcmQ5dmp2azdMVXIwV0txMnE1YkN3SDNMS01GZ2pz?=
 =?utf-8?B?OFJRWjNqOFUwV1dkL3lCYkQ1M0NZZncxakUrejZyUDl1YUFtYW1FcnFwUCsz?=
 =?utf-8?B?ekxrOW1ENCtncDRkdVpSa3lxMlBjZXJWTVNGQXRxeEo5b2tNTzdyOWpMVyts?=
 =?utf-8?B?SVJzK3VTSzg4L2p5and6cUhLQUJFZ2MrbjRHYjFSL3hkZFRNdExIeHMzUWlG?=
 =?utf-8?B?TWMzaUVQSyt5TEIycU92TWhkWVI3VzR1eFNqMi9mOXI2bFJIUkFGbnBHMEE0?=
 =?utf-8?B?Um9jQU5oMUZPZHA1MzVnSm1pYkdhVkdraXRTZndCRnkwMXorNU9iTXVhZ09o?=
 =?utf-8?B?aUE1WWlMZENsMkViMklMdlFUdHhuQkVVb2NTMXJ4dDI3UFlIUmhKQ2xqaWs2?=
 =?utf-8?B?c2hCK0dPdTZUZ3crQzlnU29yWWlKY091Ri9rVmE2Sm5NYnBPNWFKR0dBRE9I?=
 =?utf-8?B?S1NNSXg0VE5keTdGMEpGZXArbE5qSGFyUGNmNCtTSDdiaTUrY0FUbEZhN3V0?=
 =?utf-8?B?QVV2VG5jY1JNc3hNa1pkNlQwNncySFA1RHFEbzFLbDBMc3h1bUFaUERFcUlh?=
 =?utf-8?B?Rmd0UzJpU1JxZ1JnNlcrek16NFRqcGRiWnVhUUt6a213V0FPS1hSM0h0M00z?=
 =?utf-8?B?VzRlaVgyNTB4alBhKy82OUoyTHpSSmxzOU5LMEk2L0h1NkhCdzdDTGJFZFl5?=
 =?utf-8?B?Z0d0bGxrdy9Uei8yZDJRVzRZZHJ3OW9GSEJjVG1YRVhmazdpU0t6L0syMlpS?=
 =?utf-8?B?dzVNMTZMcHRXeWFrcDBnM0ZYQ0d6QitwbzlrZk1CaUNOY1JJVnA4S0Izc0Ju?=
 =?utf-8?B?VmpyOStoUE0rYlkvRjloYWFDNTJtcFhvQlhDK1Q0b1A4Tmx3ZU4rV1cyL1Bk?=
 =?utf-8?B?WXdYVmtzWllCb0tjMXcySVFzQ2JhbUdQN3RUbnZXZjUxM2pRa0hQU3lYVmJq?=
 =?utf-8?B?S2luK0t5QzJrcmlBclJ4eWtIUVFPVmM0SGluRFRCTFF6UEpmWmQ2ZUlaQXhq?=
 =?utf-8?Q?QBlym4qoOIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG10VW01ZmY4NDZSYmlla1NTSWh4RWQrYTNmbUVSdnE2OXc3TWZKdnF1OGtZ?=
 =?utf-8?B?UmlRWnVQcG9qRkNTTnNlMENyRCtqS1kyUHNSR2NWK1FoSS9OYzNJVWlNOTN2?=
 =?utf-8?B?cGc5ZmE1UkFLZHlLeXFPSmNCcUNWcDMvWkgwM3VFYlJtZndTSzdIaHg0a0dH?=
 =?utf-8?B?dk5UZE10V2xEUHVCblNHNkp1MUNaTnZ4WE1uZEgxSWJ3aG9BdUVNQm5kVnFr?=
 =?utf-8?B?Q3ljZnRxbmVaOVE4eVZqSndudEMxTjN2UHQramZFa1liM2hwdklHaG5oeVo5?=
 =?utf-8?B?T1M4eGd0LzFPWmFEMDNtLzBkN3NEai9oMVFnb01vc2lLV1FtcWRQMEREd1d4?=
 =?utf-8?B?YmsyTGE2NFNFeXgvQzFTemZXZHVXNjBsMWgwWWtHeWU5OWdOVWdhZXBRMHdM?=
 =?utf-8?B?TDVJakdQeU4zWjgxUXpIRUdUSmxPeEJ5emxJNjFnUXQzeENPZ1BTTVJ4amZY?=
 =?utf-8?B?ck1OelFtQUJPZStJOGNiWERqUTJMU1BHaFVLWkozdWZPZndGMlJxRWRvTXo3?=
 =?utf-8?B?dVRTRTNiSTBzTVdLNm5YQmJiL2p1SjA4VEdZMnlsTFR0VlA5ekZjbjR5TUVR?=
 =?utf-8?B?bThDL3BNNkF6NWtSa3dMaEFmNUo1d0tGTk5ncENLN1NIR3pBdHoyY2xWamk5?=
 =?utf-8?B?Szg0TFpPSkxjWjFJMHZkU1dlMk9SMjBoQzUvOVRpSE4raktNQWFGWmJHUVJt?=
 =?utf-8?B?Ym9qOGwwdnFtUk5DUTJxWldLNE4ySE1ybStiVzVJbjBuVUg1ckNMaitsV1I0?=
 =?utf-8?B?Qmx4Y0R6aHRRSHU2WXp5dXhTamkrYnlXRGx3Q09mWDVkeHhQUWF2V0Z5alFK?=
 =?utf-8?B?OTdQM3NvNkpvZXNtbzJJcTFKdEUwUTNQK3l3a0pNU1dQVDQ3dnFmRXhIdGtR?=
 =?utf-8?B?SzlDWVladFFhWlAzQ2I4REpIZGhGQzlrQ3VuejVGU0YzK1BucHppOXNOZ1FZ?=
 =?utf-8?B?NkNNUUpGcHk1NHFub3RuNHQxelRBclBTWjRtbjI0dTFUR1hBTEo5WC8wY0tm?=
 =?utf-8?B?WlBoSGQzd1dIQkU5a2ZFUlArRFVFYkFEbnZiQWViWHozZmNMNUgxQ2tyYXNI?=
 =?utf-8?B?My94Q203SU9tNVlUSEhqMGF4Q3kvQThvbTd0WUxzU3dPOVNnTTVIUnB2Q043?=
 =?utf-8?B?NHdtcVRRQWZMOTFCWDgrN2JQWUFRZlFGQStMNDNENTVaeEZVOHo5M09WVUVG?=
 =?utf-8?B?QlZranA2RXdRTE9rNVdtVDZJL2hYRncydDhtQldLR1BaQkRNekZNSHFWU2Rq?=
 =?utf-8?B?WUhsOEhnS1pDZXlqeXFUWWZib2k3YUpyMDl2VGkrU00zdTFEU29kRTJ6Qm1N?=
 =?utf-8?B?MzZIVkN2Yis1SEdFTU9iVkppQ1FUZGdRMFhPSm4wR3pxS0w1ZEtYNDBUZERH?=
 =?utf-8?B?QTBzSTArNTFHbm1SaGtJbEZUS0dUamd2SGlQVTlWWGg3d051QTZFTjJyZ3RX?=
 =?utf-8?B?NW5IVmM1cy9NWW5VVklTaE9sOVpTVVZPSDJrUlloSUtvZitWT3c1WC9WeDZn?=
 =?utf-8?B?aWFjeDhkcE5vcVVNOTRiR0VTaE1WN2ZFSzQwZjBib0EybUg3TU9FamZVTXlJ?=
 =?utf-8?B?UEltWTNwVFpvV3NFcmsxTytkNEswbWpxa1Q0bXVVd3JKRThNMytwb1B1SnZ1?=
 =?utf-8?B?Sk5XVW03aTZlbHNlRmxqaU8wdUloRkQ3TzhkMDkvZVIvc1hYTzZjaktLd3hN?=
 =?utf-8?B?cFlObGxVbGpFdnJLOUQydmYwbFQ0cVBrWnNyM2p3UjhCWTZzRU1pR0Zubkln?=
 =?utf-8?B?Skl4aWRmMm8zVmVnSlU1WHAzYlJmb1lGSmJhckFQWVZzUDArd05saXB6SDBm?=
 =?utf-8?B?VzJGY0Y2WlNWNWhRZ0V5c1lZUHRIWFdaZ1BHM1d0cVZuY3F2YnJmNkduZGM2?=
 =?utf-8?B?UEUxbHRYb25JR0ZaeitXNXVUY2I2alJBSXprOXQzbDdmRytLQ3BjVjlkczJW?=
 =?utf-8?B?aWpRYnRZNGpFMWkyMnJpT2dIbUVnZDExWVRxNElyVHozMTNmN3VveDA2WUFv?=
 =?utf-8?B?amlFYVJDbURNVHJ5SHM5ZVRSc3pwaTFWaUtubnphNzhERmNMajk3NTBUdzdj?=
 =?utf-8?B?Y2E2dFF3aHJoZ0g0WlZFeW9GbVZGaHZEVUZrTWxGVUY2d0FUWCttcnpEL0tL?=
 =?utf-8?B?U2VxVkVNVW01SkNPdVJmS0dxemFCNHlzYldIZk9keFNRVk5tUDJPcS9Vc2Za?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd64298f-d4b6-4d06-a053-08dd9ecc4b0d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 16:17:23.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zazqw8goOuDhXBqRfAxU4Sncx+kFPqdCMviR2N39GOrpTFNYctl6fr/1vCP9MsZ0UwhCJnzPWzeD03sv1FgeyfES7JFPJ4740McdqXPJXUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5515


On 5/29/25 8:41 AM, Borislav Petkov wrote:
> On Tue, May 27, 2025 at 07:57:07AM -0700, Matthew Gerlach wrote:
> > From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> > 
> > On SoCFPGA platform INTTEST register only supports 16-bit write based on
> > the HW design, writing 32-bit to INTTEST register triggers SError to CPU.
> > Use 16-bit write for INITTEST register.
>
> For the future, please run this text through AI so that it can massage the
> formulations into proper English:
Great suggestion! With hindsight it should be an obvious suggestion.
>
>      On the SoCFPGA platform, the INTTEST register supports only 16-bit writes.
>      A 32-bit write triggers an SError to the CPU so do 16-bit accesses only.
>
> > Fixes: c7b4be8db8bc ("EDAC, altera: Add Arria10 OCRAM ECC support")
> > Cc: stable@kernel.org
> > Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  drivers/edac/altera_edac.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Applied, thanks.

Thanks,

Matthew

>

