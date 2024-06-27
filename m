Return-Path: <linux-edac+bounces-1402-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA691AC71
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 18:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780C0281C13
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AEC199391;
	Thu, 27 Jun 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AeTttTLK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D8199234;
	Thu, 27 Jun 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505216; cv=fail; b=QLhO2u6Z6IJY/V+xOrnh7Sexe8snG1SDXygc4lIPgvlDGHEzVmmdKa9IeIEjYBwJNjxizoNzxpPyjM0UeO2GktynH5Hgcwqln40TwD6+AR+svtL918JDceKmOWuvjrIwHSbCambbSDN6LQ3Lok+rtm5K3UtKS4+z2K3aNduVFnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505216; c=relaxed/simple;
	bh=wKIwHmxZl0UoEjxdg0BnBrgbIsYsGjBT7r21nSU12T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b7i0h0p2KxdwI4UXVIkVJEoW0armzKZN2zf649PujNyi6GU3dSmKQOenknVmEMTqjoqGe7v73cy8YulPOAB7LF2mUHO0u77NGNt4fFeXQp6kah8cWEP0/GeQOarGHWFcmXEbVZn3Zwx/S3rxTR1eeRYubNkTiN0eljX3mMHP2A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AeTttTLK; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXaNaXg90NMtMGmBX7KomyDxKU8xsWWNG/DxForvKwQJIhQ0392nRf8ob/vT4F0M16yDK5WcGxPEF5GMias5+EIzg/SfrtGV/BjCkxQ+INwToPXVnwWCqOVyyboDD9LOwINAdWYgHWiEB9wW21Orj7xir6F41JD56vEd4R67r/tMt6o3dsZiebxxALsor0KTr5iHqxEBxPTTqhBfsrY7iUDaFUo+DeSISe0h8CBzLMxr99lOcboA6NwAOidSkz5WGjxeaE4egxW8qjAc/rrQfN0F4o3jXmcLj5M4UUskOml+w3e7X7mRkXP6n6/Uo2t3q8NVhGNqqo9pOb/gQk+VqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu330YjAymmuDfFIr9wi0vnxiQClEMAeKM4OvG0JvYM=;
 b=B96gvKbaoLK4sZdvGxg0gc68FItof8Qmkv/nZbmlpz/NUQk1POP06cVd7UkwNlNpcOJJlAyTkF44srmMPagq9EDXkRetvMrURS0n7H38w08URck6+xcogyoUJk9rFVvv4Te3FINoI7xf0EeQ/hGjCZFweehzmo5jAjiIKeh+IxSILVLjnNoKZKqNR5l8IxWG0foKr5EcHW/Q4gU92vHfbw0IW3tQFrUc52nzlQT4vA14qLSONXid55vU1u2vOj4mdnA348KD9yFBQMei4ut4EjFU51DudO8qVpc1dMbDju3RTvNaIXVz7Ltp2BqPM/FnEXfPE2teNFrPCeogSliPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu330YjAymmuDfFIr9wi0vnxiQClEMAeKM4OvG0JvYM=;
 b=AeTttTLKnVLg9dg0vljx++vqr8W8VPNLhfhU5apAN7peZT05La4+P5dFGFcU/J4VVnJKaFk0BFPJ5xQ637xZysFaBmoEpRbSivSeif2lBv1tzWANTy38BqM4dXTwFnNip+QQH6bSQaGN8l5RwkLQM8bi2Ssnl5LL7Jbqu6kic8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 16:20:12 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 16:20:11 +0000
Date: Thu, 27 Jun 2024 12:20:08 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <Avadhut.Naik@amd.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>, Avadhut Naik <avadhut.naik@amd.com>,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	rafael@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
	james.morse@arm.com, airlied@gmail.com, john.allen@amd.com
Subject: Re: [PATCH v2 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20240627162008.GA76758@yaz-khff2.amd.com>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-5-avadhut.naik@amd.com>
 <20240626120429.GQZnwDzQ47y1fOlFTp@fat_crate.local>
 <ff9efb14-f3e5-4c4e-8285-7da853e6ffb7@amd.com>
 <20240626182013.GEZnxb3TpU6VgROX8g@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626182013.GEZnxb3TpU6VgROX8g@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:408:fb::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d1ee42-e3f8-481b-a386-08dc96c504ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sX/dW9w3s0JBMHkAjBPcTDK5TpiH0ddhdiRlNc3ulCLU0beVKiQDRVcgBEgj?=
 =?us-ascii?Q?Eld5+Lljz1Q7x9BBejGVqgtrfdb9NhUDLXqVentwkhqZgwnH5kmWZXhj+ezu?=
 =?us-ascii?Q?96Pc3ZF5UYg9S/pdwzuEMb7fPRmlcUV7df0eMX8TK7vgczE1N4grWI/mXhop?=
 =?us-ascii?Q?pz7sQbAYNPNrOwLLPRstxUBbLbfGnFQNRlj678ULGuhEDbE8OysxvD+bmFR4?=
 =?us-ascii?Q?HbexWfpZ0IvqQags6MXNf/fYvcRULTXabvTRQoMtL66OzB2ajulCe5Ut0tJa?=
 =?us-ascii?Q?nGBQSwFrnYt3C7u5cdYYqTObD7B0YbwMxwyfGEN0hK5GDstp1QytsGuf2+7X?=
 =?us-ascii?Q?Xxw1VLTP1RF7N6K9OEVtKMrbgLoHtNFJcUCh2Gzcrza8ZA3TYEESmF8mSsFe?=
 =?us-ascii?Q?ip0SMxY4Ta/IdRFhLlb9eMuAioKXF4H2OA5lwEM4I1Jscz1bZAfwzl2URdPy?=
 =?us-ascii?Q?iqztfr+4X0v1BFBz0cHMghfpxj/WYM5jQ+/SATfqrQVx95/J+tiXvMvjhs0b?=
 =?us-ascii?Q?UazcAtYRwn/ZUjQ9SALQD6pQQ9GH+5vr8VQ10E83OJaeHY312tgo+b2RwwPh?=
 =?us-ascii?Q?j11uMCibYHlSZEfEbTICXCJ3VU6fEyQlnNQaNSMjjSpiTZrVkdEWpP32/En7?=
 =?us-ascii?Q?cdsoNA5IeM2hL9zrOX8IzqIFsUUKYMRpAISoxAyQwS3aTiEfOAgD090Fpud/?=
 =?us-ascii?Q?EhuINGwcWQkac5G/PYi8ukVh1aPCAbGStBNVf3qEmE0ZXU/JPMlFcJ6DwJ6G?=
 =?us-ascii?Q?d0RTc1EQVD4CVhoW0ZK08pRn2iLWUlCqc6WrBgQHTZ36YXP2fsACrWutDnpt?=
 =?us-ascii?Q?CbnRPde4OEGO3SgREPybW8BqJi+wTNBrOgfekgVgrUYaycLexnM+2lYLFA7o?=
 =?us-ascii?Q?MOELEFwVxsqk/gFGYx7fqbMBtYgiXb6Putoc0XgSDlGDmoTmHWydVUSBxDNp?=
 =?us-ascii?Q?r9jKyu1lM6WN4xQ8PrIQtzEpoWoQPm15URZHpX4ZWiS+WXuVy2kdzo/bt2XS?=
 =?us-ascii?Q?L4IMglk6NJT5UvkJIiv0LLTvNUD9XmyHZgPP2T+D5pCLOlPlY43UyxQy8pTa?=
 =?us-ascii?Q?1Ibd18FK6X4Cdj9NFrhjBTx8TT9gfW1DeXHJKrHbEo4XfWXVlj8VAVJBs5dC?=
 =?us-ascii?Q?q7OJY6gijyInVDB+hlMmYUSGs2Ex1TEm++xYzbliQrGqayZX95xHoTuw6cHP?=
 =?us-ascii?Q?4dSWHWpYYIuSsO069GrTbDdBJ4dB2UpLaFSdFa538zLqRT4mj+omX2KZVZly?=
 =?us-ascii?Q?o5UuhKNE8OtDwhpA8CPp1nbH/lGIc3H7ky80Do4/lHaBfMEZ2a4QVAFy/t6Z?=
 =?us-ascii?Q?aPCyBCXTSGDPPZ6YKmuTRZ4zUd89WfGlqIwDe1J1bu38xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/zvBKV9atFHNCs2gyv4lmVB6SoaWpD39J9TYiZA7/+HUnYx7xcQjDNkMVQJC?=
 =?us-ascii?Q?1v0GFv8BuRcHmdJa3sPiUO5+9w0edaBtP40NL4RBEIuaNg2b041917ugyrmm?=
 =?us-ascii?Q?aWycU/wSfvKkkgz288pOjBguoxC2d+8z+aBZp/G5yruSub4uJC8T8FPhJ12N?=
 =?us-ascii?Q?FKakX8WTODelHgb7P4FqmcBxl3WXnmP9Bo/ZXzG8Kl+3I1dLYgTDpoyhXwx0?=
 =?us-ascii?Q?dgvXLj+uc1oq5uciVhsSzNOStfvFrzlA9DCdTjudm2etiiSUtwZFL+7ZGBBe?=
 =?us-ascii?Q?sLojBuYxsX/pLDTS+xtAC9BNvHbvZQzzWCtkBDclo9SycN3HXkZerUfue9uY?=
 =?us-ascii?Q?SpFzXHHWp/Bo+XdKfmSeSLcLbAfn4qPXZMdTOT09DzmGARlTkEm23SKRqyrt?=
 =?us-ascii?Q?5sVofQRZnMoijuZ6mhjz/YJUHmJ7iqImmUHtfRU8kTFqhjETs3Vqv1ot1/rL?=
 =?us-ascii?Q?SZeBpfKDl8yZRAqBUD8qtPn5iKpwcCenfEYU4lQbfrL4m8aknS8+tBXKDmcf?=
 =?us-ascii?Q?0+jG9EktbkFa96HaEjlR3rxQ48OKHHHRr/9duSq3is/yZG+LbZcTpn15uDN5?=
 =?us-ascii?Q?i/r/EV/F4Ft3a9cvZOGMky057549aOdpn8BE9rp+FLoVDnwEjxc5Vf4/TB1D?=
 =?us-ascii?Q?artfxMuoMF2kyKcEiKq1/ieewsIo9mv9cw8GK6GuNm96KB87CNfCDFmpFL0k?=
 =?us-ascii?Q?2wNCJWRqDqjdD15VHIoutfEO4QSGRBobTWQ71JK9j02rk9iiCnJwlt00VyXM?=
 =?us-ascii?Q?W+vIOYSlVYGqY5PHNehC1f5K7V7acSaybeWWTNmfiZ4rAjLWi3V26VL4lt60?=
 =?us-ascii?Q?QedyscgdennaCuQ4ixkh0TRe7751kP12fyPNeyIR96RuJSMw0BwLmlFmISCA?=
 =?us-ascii?Q?ERSY3CiKfA7WkWsnuZAqKQEyDE3Vg3XUdzUsVNrVjIBHLZTRTvpvrwMSPzf6?=
 =?us-ascii?Q?s38w5HVThTjEsqs4IYLwUzLSUUZL7iK9T8YfMb1DoxmjdKF04p1IRshsSgY6?=
 =?us-ascii?Q?llprTrB7Gfvn8X5moh8/VqhZ7jPK0egwzMo2ARpzb5JGrRjwB2IDgx5bQ+N5?=
 =?us-ascii?Q?JdoDOn0vfT31/55xNWCmk+uiaxrbCdZEeRmROCekdU2Phts9rvAZo7z283+W?=
 =?us-ascii?Q?uZ+UwvH6KG/T6Rq45rcikzLiLo4vupOFHiwglYBmIiS/B8N0iIVJbFSFykZn?=
 =?us-ascii?Q?Xq+EsTgfufCLCZWR4WMLNyv8i86e2ehsONWG+twlHI1Q32pNjqnj5qWcmTNU?=
 =?us-ascii?Q?6SqzFr+Ep3y/iFXihTj9nYgd/ok9CeTiUGYTBvVjTXtF5Zwccdo6pVnBSmq7?=
 =?us-ascii?Q?wDVzs2lcqZZ1z6WHWgyGtUwtOQnEcc5/HrcuBZANRRXc9ZtIGa3050XTsJeJ?=
 =?us-ascii?Q?hrT3ATXg4fYKNQq/KeUbWXql4Sdh9fyWrxkrAVgbOmhU3qz1uRECLxJTNy7E?=
 =?us-ascii?Q?OXF7U1s7dL+eeFcmLfow66ydnFKw9AkLLzXT5tpiFc6gYbWdx/vjek/SspQ9?=
 =?us-ascii?Q?dokVlHa6tBMzIgE2pQacInzD9FyaxdCzlr/uh/FSYpXi9LsDdzX7r2z8Ifya?=
 =?us-ascii?Q?5ASdgMw6YI1Y47RQw68D68Ay802FIE7OvCixDsCE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d1ee42-e3f8-481b-a386-08dc96c504ea
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 16:20:11.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4sBmlZsP2R3jMb9+Ujr4T4Li/hL6OB5/LHktkbTVUeqUCsPnYJXq7+HxZ1r2Py5HdYPi1anIt6HfIjt+Cey5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508

On Wed, Jun 26, 2024 at 08:20:13PM +0200, Borislav Petkov wrote:
> On Wed, Jun 26, 2024 at 01:00:30PM -0500, Naik, Avadhut wrote:
> > > 
> > > Why are you clearing it if you're overwriting it immediately?
> > > 
> > Since its a local variable, wanted to ensure that the memory is zeroed out to prevent
> > any issues with the %s specifier, used later on.
> 
> What issues?
> 
> > Would you recommend removing that and using initializer instead for the string?
> 
> I'd recommend looking at what the code does and then really thinking whether
> that makes any sense.
>

We need to make sure the string is NULL-terminated. So the memset()
could be replaced with this:

	frutext[16] = '\0';

Or better yet, maybe we can use scnprintf() or similar.

Thanks,
Yazen

