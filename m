Return-Path: <linux-edac+bounces-5118-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D1BE935C
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD316E18A6
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D727FB03;
	Fri, 17 Oct 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDvkCIu+"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC757339715;
	Fri, 17 Oct 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711509; cv=fail; b=Y7tfhggZPnq0M+n+9Z2iZyvp+uO3INp0INTiC457BIJcNFL3cucJnXxn3JAGVFqpbeTfeo+v1iu+IpDh0Nv6zni6RMEotqRoANA8ML2qXXIpsZfxP4GlQI4fs6Ow7SUU/q0rTiKn2OLoRQr6YCMJ/ot6hsvqJ/hPFRIcAe8dGtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711509; c=relaxed/simple;
	bh=A24KhgdyjQPPTAW/tf2UDSeHxzU/3LlHV/vefYCTSpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=asO2gNS2v0TmBwk+L9538f913pJ/VHrpq50pQf03Fk8f7Anynz+WOMTw8ANE2soh+r/LdB5qV1z792s/7o1Xbrdz8+uT0WOyY5xNFpOcdiYyHENcvq4mtgx6YcZNPRUWbPfuqLmbT7Vt/fx6iM1r3KlG0Z1VXp9p+NKgD+b8/vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDvkCIu+; arc=fail smtp.client-ip=40.93.195.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNtXT8qhV2JH6YOAIK48h0tUsxyrbNqEg+9o4/GqgXo7hs6bG6UFsWkxkKBW19uuZsfbareqWqec5qfZUQmZKQ1DkNAfmhnRHIcCmOS2N3V2tRRfr+Ruj35g9jsREEaMvfdzj1UqJFQ2XgL8vdlnlW5fKTD+elNwPxTu6i7QB9PPc5tACVFCTNRstaQiNuN4cvYLDJrzcJTDn+DRsfcFlq/tPz9RPJkEEqEi+Ct+9zXqQwXBPhR7fFCObYfM6vhq+d+S0niMWEgzSFlcQ7KJ8D7L9aYYUlyGiNpDDfzRKA36ceYa08LX8Ide4OCaxP0BnwdwChQjlBD9T5/xb6Xy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kZEbcRpDeXecPuDswWwZk4wwnszot1vbaYmF/5YE9I=;
 b=V1Co4Hwb3R6wCV+trvLc/5d9fcZyHeFAw5II5k+tVt7zo+9BBeCiWwr0HKR0UdThDTIbIO1ZYylu6zsMEtQAH+DgiNrW+vz0UxcZSLKgG/c3U/Jw98/BNoaCcaC0HeK+kFeG9ZjD3nRHGiU2EoF0K6rZ4Fdd3F8KZstytbFawH0CRTfsbNfw5A9MI/nwd48MecqSMccd9NSegKiVxFDEtUFl3R54EGn/ZBb+jtrt6Ls/AoEuyAhFAIFE+NmbGN3860qiM1xJ8a9ftGI2b90Jb45MHdm6+bIU2Jkzxn2WQHsB3EsRdzBpyWAS47YE6X9g2RNEv3/k3y1wO2cdQBAfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kZEbcRpDeXecPuDswWwZk4wwnszot1vbaYmF/5YE9I=;
 b=uDvkCIu+Wykn4/L3xgcdBjkmB2Rp0CTzk86XHjoS+KtIPaOW7Vn4dznYy2YSEWj5YN/rrAUtwbdICKdfpCLdF6wnrOfgEivDXgSRSP1+1BfZZj+oqZ1HAwkhaGZF5MkK1pSnu4nRxiBkqJpN07DiT23TgnnHQnteIE8UoffMtxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 14:31:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 14:31:44 +0000
Date: Fri, 17 Oct 2025 10:31:39 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mce: Add support for PHYSADDRV and
 PHYSADDRVALIDSUPPORTED bits
Message-ID: <20251017143139.GA1131586@yaz-khff2.amd.com>
References: <20251015172452.3649720-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015172452.3649720-1-avadhut.naik@amd.com>
X-ClientProxiedBy: BN0PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:408:143::13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: b4920047-47d8-440a-5364-08de0d89e50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vU2K6H99Ew/M3V1Qfsc7Zkv1nZ8pyyQHXVXxMi7+SJEmB5Q8LGoZnJYk48Cm?=
 =?us-ascii?Q?qdj/7U+ClMjAcQmDCmThrgH3dVViTQvEPmneW+1QpgLLntQ2E6i8v2LoMO3h?=
 =?us-ascii?Q?bTlucRRxH0OrwwQPsv/gNKqWEP9eto+UpAjxZ0bN7hxgVZnBj9YqXMtQqvMG?=
 =?us-ascii?Q?ousJPF+ynaaXBIouSBzaiQiul+qmSpZLLVxSF1PmiCL8mHYi99cnTJo4e/Ti?=
 =?us-ascii?Q?fCco2Cnap8XUMlF60AjZFK888XxxpzpXzasc9BdrhxINs04HouI6oVsy+mWs?=
 =?us-ascii?Q?C+9XBvjg/noCXrFpkeGeoHwS3kFPXjDNNk2jThhT2unlWf03uH9mFbjEIBJP?=
 =?us-ascii?Q?5DTTVLHG+edgeT9YtM0FO3KI8IKCj0n5s1K6oexlh7h4238TpPta0DBZbBcG?=
 =?us-ascii?Q?EoQG2Qm5kbreyA5wg2mi+9dgiQtCFWPIW9uE0UUyDagYYgdD5N+3DJIeLFix?=
 =?us-ascii?Q?OXT7lfBI2W9wOa59nlt2DzQSvtacEGvcW1CMkKgC3PS7hVKL56Vknx2iPRoR?=
 =?us-ascii?Q?bARP/02CWc5WCwLvUW2NDbBr/H8WysLEPW29jE+qE5I7Mlog2GnmSN5NN/jw?=
 =?us-ascii?Q?y/TTdEh6TOlL3lJsF9goINw4MYJQFy0sSXph44Ys5/hWfkRdPAcPyA8Pnb4d?=
 =?us-ascii?Q?L0dtGrN/aIyeODnxl/bs2xS8LSsJzGYRHm3FqIJzjqxqrYO6ddrnZBRzLQ97?=
 =?us-ascii?Q?s8L6vW+5NjuGvW2zFC7lQhexfkIlkz84ku0ueLTAVIqbjxQIgt7etg5sqBnA?=
 =?us-ascii?Q?Q81el+k9NR5KZk0Lurm7XNP2PB1KzLuONyxx4Gz2QjScLZvBevznpRLm7LTM?=
 =?us-ascii?Q?bCgUn94WfT+WYlP/otnBT6u9h/KsZ4Y9Ctkt/C2YT36e0UBEt86O1EXxohNj?=
 =?us-ascii?Q?5vws845+Ri0BCfxTTNJEr3oVAhHrcpcqMCcDLqHHURjh0V8iRIoz5ZiqTZn7?=
 =?us-ascii?Q?tcvhArIt0qOQ1JO/dN7j/nNiQ/FSOPGbv8q7a0q+nMUqYtGy9a4aMkde1Icj?=
 =?us-ascii?Q?U69PcwC6sgxmQa++liCy1lbXj+jzUpLSKe1usYtjIZpzhdCNhaaKqkSEMA4C?=
 =?us-ascii?Q?v1iDdHLajrQ7GD4uXCvAWmzjeL1iSo/FOeOcdEPNsqwzjKwPUDXn2aZh9e7r?=
 =?us-ascii?Q?ClllCtRH2o0NsdXrUuwMICVWoaFcm8Ly8czdLmc1GKe5Zqd6LSG0oQNcqxbT?=
 =?us-ascii?Q?zf9H2d04VzlXryl9Ca/QuNNHgMxKikoQ4Iy61xjb9OuFLnR/caIAtiovqY37?=
 =?us-ascii?Q?bsZQZ4VdTHcIaKfc6ck4yEgRiF3AQ4swIdKqpqkInelKiJyFQuv/gI8t+UbK?=
 =?us-ascii?Q?yHQEVMvFwMtgxfMGueERFwlTaaq6gNWJg1R3fskaaY9VDFlaEMqry3wEWg2r?=
 =?us-ascii?Q?Hv+IuqX0pu34BZrGoaQXD/6ZEixsymQ3c/1jBA9GnnLo3PPcaPTItL33h78H?=
 =?us-ascii?Q?hrQDHRDZmx718uXcXMdkqm6hMdOytXqQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PMhSJRXbrTzlGcoyZvazyeqA/ZFymuMBeUF/V8b3mtVFy5Dpv40vOkcHqyu7?=
 =?us-ascii?Q?fLwidwo3nvimXj9ze6UG1ZDojAdXbiOUf2L7j12WIhGfqB/t/hJq9ZUJ6CqM?=
 =?us-ascii?Q?Anqo6kBDapP01UQGbzXQITz1RLC2P+TF5TIWcfuMrplnzCheLlSExyPDbFRS?=
 =?us-ascii?Q?9Ko5dJ4hyK1vspDHfDDbpocCW1AriYS5Hs0c7ZRfyLbhhLJxaBFKZt6sbB+L?=
 =?us-ascii?Q?4zE2k0LVDII3WUzLRE6E4kctdXx/ycN4+tIAusLtcVeac+RbpyD9pS2MZK+B?=
 =?us-ascii?Q?1NFKSnhjIVrO4vmPvyty1mVq4TSI+P5cPin0vLRkV1K6UQTZMfRXliC86+1+?=
 =?us-ascii?Q?lZbEnicjBCLsJghKglooNiS8r7iSBSs6w5jK+cA0NU0e5PPwJpZtOCYUC4UE?=
 =?us-ascii?Q?jmGL2WARq5iaPKbF+Nvg1beiyoWjtZgMGaIHkQYDyHPsunkKVIanWflx+5VF?=
 =?us-ascii?Q?c9/Wt1l/SH0ojzL4UuUjM9OriXI6ubtp9mb/6+rwoJTKDOOQev2oylnhwY2V?=
 =?us-ascii?Q?gRQbeH9gWHFrVH9VyjfbFeFYTzvhOrHM04l6dncaBjQ7c4SK1MRrHxCtV8Dn?=
 =?us-ascii?Q?w4tPR8spHG/mxXgrvOhMR2i6Ks13IrnXr6TAmycybPY4g9ukpQc1K/CUabnT?=
 =?us-ascii?Q?yeezimZi9+EIGhOCI62nfxgNN7izpMc/nXbASjWA1ENebfW0NSs17yocr0QO?=
 =?us-ascii?Q?lwP6nCqkS4C7daMikaBTvSx4hk+Imdlc8rv3bU99VJoK6f/VbOgdQ0b1VsdQ?=
 =?us-ascii?Q?nHf+MV0bdkZw5sPpNMfgv7rkME5Kqca5JUB6MxevR9U3EGBWfVPBsaWOz+2s?=
 =?us-ascii?Q?a2f7jxpIu0cLRoy9Xaa7ZIfM7BNDC+erw8N8Ci+Ghp2IxlTLQLnYpmDjl8tz?=
 =?us-ascii?Q?CZUeiU8JgFhtdTMcPtgQCo3I0NNi+Sn92HvUhV7idEZRVtpT7mR6WwB6yL/l?=
 =?us-ascii?Q?dblhCRLYFD4TQ/Ks8qup0cUofGPhmMGL15zQt83Hqs1el34sZ3uZwc+GyY0o?=
 =?us-ascii?Q?Y6wfbBV+x5n67ZOOLLCw6bmpxEA6uJexeHgFpT3yUgfrRZmOQWGnTJgvwzB0?=
 =?us-ascii?Q?EzQkVnQP8fDON/jwUMZ66r99NdJxS1jaNhxxsaurFN7c9giHWlfc3S4e3CpN?=
 =?us-ascii?Q?efgl5ADSmHGklgpoxF1IyVm5PjF4j67g17T/Q2Ha3sRmI4u6XaUOqHA30x6K?=
 =?us-ascii?Q?cmZ7DjdaALkaZu2M3Tzj/ZsnFn5qtc0Uqd2xKmVofPaF4Wr3aq4QY+FzzjLu?=
 =?us-ascii?Q?PP9XaMvYRbNHRfelbHSJttC8QjLnwzzutyJABpFfl4t+IFj4DMGWgXAV3tyn?=
 =?us-ascii?Q?4NCrSVmvyfZs3NRcHpQEVfiKOqVsBYcqnF1pGZ3NLNYRTOOSMOlE09JBSnzC?=
 =?us-ascii?Q?+RTIfnVhmWLemdti/wPzDzJOxZR7qtxd0cqpHme3i2fLbEuUtEoqBzqotpEo?=
 =?us-ascii?Q?hcp+JcuntFaBbnql+6HmlFnKaxxc5GaK2Bf6YtBg44F1hy6I0qp4/HwlqDxP?=
 =?us-ascii?Q?d6ap6NX6MNqbTvGbbDAKJNGZXlkoUYxzuO8c5uB9+lwlM/A7uIZusl6TnAvS?=
 =?us-ascii?Q?0SJquuNBQdnS9jXPJrWOztClPeCy8MX+klgyoRAm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4920047-47d8-440a-5364-08de0d89e50c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:31:44.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1k8bJiqLRDufQOtgjyCC7BovbXXN/fhQJd9KEkUiDMg6AbYVIoeJ993lZQbDohEfOCTWFDnhbml9KKU7GloaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

On Wed, Oct 15, 2025 at 05:22:25PM +0000, Avadhut Naik wrote:
> Starting with Zen6, AMD's Scalable MCA systems will incorporate two new
> bits in MCA_STATUS and MCA_CONFIG MSRs. These bits will indicate if a
> valid System Physical Address (SPA) is present in MCA_ADDR.
> 
> PhysAddrValidSupported bit (MCA_CONFIG[11]) serves as the architectural
> indicator and states if PhysAddrV bit (MCA_STATUS[54]) is Reserved or
> if it indicates validity of SPA in MCA_ADDR.
> 
> PhysAddrV bit (MCA_STATUS[54]) advertises if MCA_ADDR contains valid
> SPA or if it is implementation specific.
> 
> Use and prefer MCA_STATUS[PhysAddrV] when checking for a usable address.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---

Minor nit:
The $SUBJECT could be simpler, like "Use new physical address valid
bit". And leave the details and proper field names for the commit
message.

But in any case, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

