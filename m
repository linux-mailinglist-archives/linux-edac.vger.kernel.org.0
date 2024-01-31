Return-Path: <linux-edac+bounces-414-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0A844350
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 16:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1871C21739
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782D128388;
	Wed, 31 Jan 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gc9aS4AQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157C129A8D
	for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715964; cv=fail; b=TOXar6zZSx12kdjrogg1MDGM74VVLACk7lkhf0hKvke/kCx81ccJp8C/W3+j15zKPwYAY2t4NVoh+ECmaSZ1HlrDUarpzdf+MsGpOSroKOT/dlE+InxExgEeCWYv1sJwOu/UMwfJmfiv9uEUpleBCG94EhdzvheSfN2HeRpL4SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715964; c=relaxed/simple;
	bh=L2OIw8JLQMoR/zyDFXyW/emUYtBvGk+xrzeyZ4uV6Qo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WX0Y+WbmONODRLq8pW46vnU7MhuSKdo6H8Lm8k1oWOehGfvTK5gXy0pfGuBYhkJ15bxMwv2qOKW7oRh+AbGWqFyJI1sYvyM6m7RxovQSIowpzENld9dv3pHxUbFZRQ1b/c91Xui7fXYIvJIGOyIuuJ9Qp40mwIcHbt1rjjJn+ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gc9aS4AQ; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC3VG4O4b9PalKXt5h+K7xsu+o91OD7BDpAeWMwZyzG/eh+MaPiKp/GfvJVRYJd22xwRKSq6EHz5Nfh8GzAexnZbWhkN5YJHhn/mXi3Kvu4Fm1QUSMQ6hi9K2vy25q+3+h6901Nom+xHWxVTAUTeofmwCfiD9hrnu7AKJqiGaNGcLWOIq0I/dsOBK1AA8cAhzQ+Vl99HBV9K0iQkKKZ4xY2JkeCIaQLbc8ZnCcnz3gBY9k9XGNmp0X/aOunTWse6KwlrC1Rn8HRoIiHGWemprKb+3g8JnBYQpJNrb4sa0AAmE48qWPo70/rXquNFdDmwvtscTcaicrZeE9Q8UzOICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P314ur0hrr8fPtBG+ulLroP5UuDmad9j+4J1doMsUYQ=;
 b=OM7iHMA+/sOxmEJwMS3accttgsNa20zglDb5zk1tNqoMPuvdfKaxtgLdtcxPFaGkN39GKHjZG++sPqjf+UVQBpEnEdEOh45IxgNgMERGULWys+Q041cl++XH0CuvwQZ198zL2oYMiEVGyZET9WThMwnYSGU9lISUmdFb3NLukSanAj+RBzaVKar0Y0zsiJLjNoP7xUA8uKWeTwg7NBYTsdDsffN1kzVAGGONZTpxF45MNn0AFjdmdlO5A99G8yE9TlUvMPxoMthcGTBHgy4C1QbTFDGsyx2vwK3t42q7chYIOYBKs0ORIGAgXazPPfVDM2GEl/dFSVHiZjWK7UBhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P314ur0hrr8fPtBG+ulLroP5UuDmad9j+4J1doMsUYQ=;
 b=gc9aS4AQxAOgKITsgHCGOoPfe/Xh3Y5ByFu3ITJRIku4ux4PLf+UChtq7JujXDnRwTdvFqAbB8XxEsS5W7Dma+nexfuPn68kHHZ6n90vliJn0kFI7ZyItQjO4qyY14X4lGHctPlhiQ5SYFpu66nhfVbaul1/FBrV5h+w9V4nk8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 31 Jan
 2024 15:45:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:45:56 +0000
Message-ID: <1b3a758c-7928-4486-b63a-bee977d99913@amd.com>
Date: Wed, 31 Jan 2024 10:45:55 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, muralidhara.mk@amd.com, linux-edac@vger.kernel.org
Subject: Re: [bug report] RAS/AMD/ATL: Add MI300 support
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Dan Carpenter <dan.carpenter@linaro.org>
References: <18bb00a0-5742-47a5-9dd6-c35c164114e2@moroto.mountain>
 <20240131085638.GBZboLRr6jsZhqwjfP@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240131085638.GBZboLRr6jsZhqwjfP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0869.namprd03.prod.outlook.com
 (2603:10b6:408:13d::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b20029c-8600-4e1f-a7ff-08dc2273b6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	82cJZkdjZihiU2UTsAzz4wAuUqDMuNJce44C59ql6BfcO+MPZiX0lDXhJk3u1vdmGlNbiflcs3aUkTsYtDJMrMNhRrga94TE3L0M0auKHyk+3ODcgjCiZSpi6o5X5B1A8FzaeGeDblKRcuAa0jK0cyOVLFj5JITH0K+CidFwEaR4al9roiugk7w6F7MVwI+nKSFPfyKeq/Onf/OTg4b8Pn+H5uuyp9bQzwlP2goTcl2y22usx8t8TRku8L+PeuXbteHZKA0pX4Mqd6T8XOh49yocCvSMJHz5cOuLFhIywvvIWmITfTxsHi8VMeMIeFTUrpzLo5Zjmp2RhiXlTG7bjcb0Ol5NRQ+sN/faTCBcyfL66Cbacf6qaYCP8EDFUWkKzZUFt7QhcDhpFF1O+D6PU5sbHa/9ZinZXibOpW++00M+8/jeF7xmll7cjaod1I2toIUFmzC1wao5Z9M9aH14qBg2N4lXCgvX/zYvTlR5VjoSUpmMCoE6miZOdont+DZ3UODyeopr00tHtuD+i6uxBD39Mx/sha6BxaMEYiCf6fJK065dMFegbzkBg9iMm+Yk50dJ7ifO1GUTn2JwpZO2z1xS4BKqqr/eaUm/n+q5pLWuytjSmU6WV+oXY5Duw1EJ/pHU8k3NiERb2Fx8EzUcGj7CGXDBwAC5y75mMwBu5mc8CsZeLRyA9VMLxSEesIO7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(36756003)(41300700001)(44832011)(8936002)(4326008)(8676002)(6512007)(2906002)(2616005)(5660300002)(478600001)(66946007)(6486002)(31686004)(86362001)(31696002)(38100700002)(6506007)(110136005)(53546011)(316002)(66476007)(66556008)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjV6Qk5nYkZkaWZmajVVV2NYTGhJZy9iaTE3L282VzZaN2V5UkF6T243QlZ2?=
 =?utf-8?B?ZmdPbGhlZC90RnVzNFRyL082VGEvZ3VxNHdFcXkrbjFsOFJ0STFWRVozekdp?=
 =?utf-8?B?Mm9IT2cxRkZZUEM0KzJPYkpmSkZETS92UnRRSkMwWHNCRWtPMTY0WTlPSGdY?=
 =?utf-8?B?Y3Fzb1NHNkJibndLSHlVWlltY2FxT2ExR2pkMmJFQjAwMm95Y3pROTQvR2Qy?=
 =?utf-8?B?Z0l0Ymx1QjlpbEFENUpFdlFkYmVOem5BVFRVa1ZoQkVmNzRYdkJpcDR6T2Za?=
 =?utf-8?B?Y0VCTnUrWjlDd0o5R3kxdktVUmp3ZFFoYUx0clF3Y2V5cnRWdDJFclBQczlO?=
 =?utf-8?B?Vlh5cE43ckJkMmJXYTZJaVZ6TlV5K1NUNkgxV2txa2NTQkFxVzBPUzhpeW9Q?=
 =?utf-8?B?OXBmWlZQejFaODlDRDZiTFJQZ3c2SFpSeHBnU3g4L0h1eFdSeUlodDZzK0tQ?=
 =?utf-8?B?MnVjRThSUmJXWlNyM0dZUWRPR1Vxeis2YlIydit2Yjk3aXN2bjlKZWhENXNG?=
 =?utf-8?B?Z2xCcVlBVEVBeFdkZkl1T1A5dG1OYWxhUm83aUVGU3hZMXhFekU0MUg1Z1g2?=
 =?utf-8?B?KzRMUGZrWkkra0VEWmRDQW1seEZkZEpPaDdSTVp2RDh6RzhmSTZOOWl6b3ND?=
 =?utf-8?B?ZjhqVmUweDNRWTN5MDcycEJzZW1qRGNrY2RBN2MwSVJGNXMySGdNZHdCNXRZ?=
 =?utf-8?B?dHNIZ1JCNGxGTytscDFwMFc2YzdzU28xYWlsNWQzUSsyR0NQWHBjVUtibHRL?=
 =?utf-8?B?VVlDa1pESmQyc3J5MVVlaXd4YzF3U2wrRnhrUFFxNy9XVXlKdDNKcFdBTjZr?=
 =?utf-8?B?dEd0MDlWMS9oTW1zSXR2dFg4a2pPalJ5T3BJck94VHorcXBhUjBTakVuVHZO?=
 =?utf-8?B?b1djZFdwZTBMTDdXVFg3Y25OeXNSVmJtVHBnQ2RWYlAxcHg5YXAwaklZaEFu?=
 =?utf-8?B?V3pQVzNacmR6dm55eldsVHdjOFd3SUNzK0FIS2JFMTlaeCs1YXRQZXFXWUxZ?=
 =?utf-8?B?NGk4ZmJ0cUFHbWRhbFVuVEtUc2ZxUFN3bm13VUZsZDU3TWNJU09rU3JMdlB0?=
 =?utf-8?B?SVlWK09DZmtTZUlqajZEalcwRGFiMXVwYWU2ckZiOVVNVXlRN3I1QWUwOXZ5?=
 =?utf-8?B?SzhLMmRML0M1ODRjcGt5ODdTeDc5T0dyTnU5QUV0RWREbUxObHRta3NOWnNG?=
 =?utf-8?B?dG9xY0ZqN1FpeTJheU1xT3A4S3Jyamg0OXUwTUtLQ0QweEM5MVYzamNLeFdF?=
 =?utf-8?B?SGNQc0k0WWJWbGorTCtGMUxsUUtuUGhRdVdpTFNOelF4RkttTFNOb2QyeDBp?=
 =?utf-8?B?MFNKaU5hNi9ybVdwU2o1Y1FkUEFFUUhTWWFJejJWSk8rS2ZvOUcwM0xwQzA5?=
 =?utf-8?B?aCs5VWhOT0g0OURPMG5HUDRmNnNFdmtTc3pRMXM4Y1luMUVTeS90NjBFcnFC?=
 =?utf-8?B?N3RzT1BlbGhxYnp0R3FXV0dMV0J2a0RMUkx2SUkxbjF0ZVNPOUxHekRCaE01?=
 =?utf-8?B?MEorcTcrdjhGNDdvL1VQR1dYbVlHSS9wUitpeTJ4YTVkc3ZqZTBCNFpxM1l3?=
 =?utf-8?B?ejJlL2wzb1E4Z1pBUFJiclFxY1NIMkJRaHJTVUYrS1E2VUxOVUZaU2lOTnlj?=
 =?utf-8?B?ZU1XTmt5a0FHdUN0K0QwWDFvcVM2ZmQ5OExVUGtuNFQ4OStFTW55VGg1L0JR?=
 =?utf-8?B?dUhvdTFvaHh3Z05XdkFYcm5GeDAxaHBvMmhoRWdqamZmd0lGUzhuekJzOHps?=
 =?utf-8?B?Ujd1WEZyNHR3WFh4MGRMWGtCc1U1d0V5bVZBR2FZVSt3SnZ5dU5lb1dHN1Y2?=
 =?utf-8?B?a1pnVTIrSjN5OTFlYjBYWHN5Ryt4eTdZK1FTTzNoZTZmT01IM2IrVmp3TFR6?=
 =?utf-8?B?dGJDbnZpbGZ2a240MEhiaGlHMHp6YlUvaCtBeVRJL1F5WHQ2bkRqaXlFOWto?=
 =?utf-8?B?VSszc0E1QWZwVmluUUNnQkEyekE1UWVkblBhOE9Sc2dCamd3TXo1K0tZL2h3?=
 =?utf-8?B?N0pENjBDK3QxQjNZeVl2NlYvOVJvTGI1RzhhbDgzMEx2MWNNSnF2WGR1eHc5?=
 =?utf-8?B?ZlF0b05JV0ZQbXBpODZ1aktRZ05yeWluaUtvcFJoeTJLMkJSR0p5Z0JBSDAx?=
 =?utf-8?Q?e0f8G/xrODF9OQ00FLiSeO4cd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b20029c-8600-4e1f-a7ff-08dc2273b6e2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:45:56.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/VwLzQNjbafW0ej0kFojFCAE3BQUD/r2okiToFh2uD7nPN1RJpmPlIYua+tqFfT5UIsWEzYZe2QV6mfelLWTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

On 1/31/2024 3:56 AM, Borislav Petkov wrote:
> + Yazen.
> 
> On Wed, Jan 31, 2024 at 11:24:37AM +0300, Dan Carpenter wrote:
>> Hello Muralidhara M K,
>>
>> The patch 453f0ae79732: "RAS/AMD/ATL: Add MI300 support" from Jan 28,
>> 2024 (linux-next), leads to the following (unpublished) Smatch static
>> checker warning:
>>
>> drivers/ras/amd/atl/dehash.c:389 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_4k'
>> drivers/ras/amd/atl/dehash.c:394 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
>> drivers/ras/amd/atl/dehash.c:396 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
>> drivers/ras/amd/atl/dehash.c:398 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
>> drivers/ras/amd/atl/dehash.c:400 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
>> drivers/ras/amd/atl/dehash.c:402 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
>> drivers/ras/amd/atl/dehash.c:419 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_64k'
>> drivers/ras/amd/atl/dehash.c:421 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_2M'
>> drivers/ras/amd/atl/dehash.c:423 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1G'
>> drivers/ras/amd/atl/dehash.c:425 mi300_dehash_addr() warn: bool mask is always false 'test_bit & hash_ctl_1T'
>>
>> drivers/ras/amd/atl/dehash.c
>>      357 static int mi300_dehash_addr(struct addr_ctx *ctx)
>>      358 {
>>      359         bool hash_ctl_4k, hash_ctl_64k, hash_ctl_2M, hash_ctl_1G, hash_ctl_1T;
>>      360         bool hashed_bit, intlv_bit, test_bit;
>>      361         u8 num_intlv_bits, base_bit, i;
>>      362
>>      363         if (!map_bits_valid(ctx, 8, 8, 4, 1))
>>      364                 return -EINVAL;
>>      365
>>      366         hash_ctl_4k  = FIELD_GET(DF4p5_HASH_CTL_4K, ctx->map.ctl);
>>
>> hash_ctl_4k is bool.

The bool will be true or false depending on if the appropriate bit is set in ctx->map.ctl.

Is this not correct?

For context, the intent is to use bool type for variables that contain a single bit.

>>
>>      367         hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K,  ctx->map.ctl);
>>      368         hash_ctl_2M  = FIELD_GET(DF4_HASH_CTL_2M,   ctx->map.ctl);
>>      369         hash_ctl_1G  = FIELD_GET(DF4_HASH_CTL_1G,   ctx->map.ctl);
>>      370         hash_ctl_1T  = FIELD_GET(DF4p5_HASH_CTL_1T, ctx->map.ctl);
>>      371
>>      372         /* Channel bits */
>>      373         num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
>>      374
>>      375         for (i = 0; i < num_intlv_bits; i++) {
>>      376                 base_bit = 8 + i;
>>      377
>>      378                 /* COH_ST_Select[4] jumps to a base bit of 14. */
>>      379                 if (i == 4)
>>      380                         base_bit = 14;
>>      381
>>      382                 intlv_bit = BIT_ULL(base_bit) & ctx->ret_addr;

Since intlv_bit is bool, I expect it will be set to 'true' if the right-hand-side is
non-zero. So shifting and !!(x) isn't necessary. Is this not correct?

>>      383
>>      384                 hashed_bit = intlv_bit;
>>      385
>>      386                 /* 4k hash bit only applies to the first 3 bits. */
>>      387                 if (i <= 2) {
>>      388                         test_bit    = BIT_ULL(12 + i) & ctx->ret_addr;
>>
>> test_bit is BIT(12 - 14).
> 
> test_bit is (BIT(14) & ctx->ret_addr), if i == 2, for example.
> 
> If ctx->ret_addr has bit 14 set, test_bit will be 1.
> 
> I'm confused.
> 
> Leaving in the rest for Yazen.
> 
>>
>> --> 389                         hashed_bit ^= test_bit & hash_ctl_4k;
>>
>> BIT(12) & true is always false.
>>

'test_bit' can be 'true' or 'false depending on the value of the input ctx->ret_addr.
And 'hash_ctl_4k' can be 'true' or 'false' depending on the setting in a control
hardware register.

Am I misunderstanding how the bool type can be used? Apologies if my assumptions are
incorrect.

Since a bool is stored as a u8, is it possible that bits[7:1] can be set? And will bool
operations only use bit[0]? This would break my assumptions regarding the bitmask uses.

Thanks,
Yazen

