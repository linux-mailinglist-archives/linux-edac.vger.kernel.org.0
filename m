Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C677C4D3CE0
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiCIW0d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 17:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCIW0c (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 17:26:32 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7834D120F45;
        Wed,  9 Mar 2022 14:25:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsDZ9jqan5Lf5ivnqmsgNmzrNsttj2dhhMmXOZKI7UDHdBwoeh0OvFOrACtJ/32mJJ/INZn4wHoPg5qCRBcJYbOLAUIDkJJ2tg0uBihNFRS4lHhjjm1D9gOuYpivqLOsdzhk4xTrEhYZg4Zrbvw3PL/vHqmXIWYDI6iNdDxj4gwZ4j1Vlz9u8C7SGy5afYyuDF0jX9AqgPaGFzeAWxCjj7E/WFfobGulU+JcvqGSIhr0Fr+9pl15DwovZo0Ssnj7ePAXhHo/fAdJQy7NLuOdtr9UBSqXSIkGJcqS+GJ3Bhm5h9utNlGgX75YpOIP38QKXU8lk/WxN6FF9ha3jU0i5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxC2DCDP4bRA3iOtqTNobEzuxFobkWV7IJ84Pcy+DyA=;
 b=iVzOKXoNCpr1w2c9o4fTlQZzwp37C7+kn++20W0OthIvmCO8416TSmfYZ9xiMqLPPDcvE7a240ThOYyFFRZlosgQ7KAtAE+QWr+CoimZgzOCOAtcoYJ5ppZBZ80Uzb6399kKVudTTWAQvOETdeySQRn06it/Wy5j83p7CorEiwyOUGNPdo6R56ZGFBtCfpt4GrfMNtoRvN8xlA/HUvsIb3EknH0AkZ1X+xJauEqPqpIHWwWxiIWXF4bBWsLALSU938nuYPOzr+JJO+itkGe7llX+ZwfkCveDs0a7sh2QwbMhDa7wbKUfQ9iY38FmwCzxkxrI1DUS3DGfjKc1AQfnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxC2DCDP4bRA3iOtqTNobEzuxFobkWV7IJ84Pcy+DyA=;
 b=y7TmLsr68og1SUstALIH14TRSv9ChY+phZkdB5O1Semxa4kgE14Xv7DUigmYqhww3e5F8BPGF3qpZtNnBGqWhF+TrJ3jkR4+heW/8I+d0Ag+lWfwAboqy/DEaYmFOT+Lh4VyAGdOGm78zxSjWhikVWKciJb0erWi07dLyPqnOB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY4PR1201MB0198.namprd12.prod.outlook.com (2603:10b6:910:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 22:25:31 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 22:25:30 +0000
Date:   Wed, 9 Mar 2022 22:25:22 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 16/24] EDAC/amd64: Define function to make space for
 CS ID
Message-ID: <YikpUrojo1cMFfOp@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-17-yazen.ghannam@amd.com>
 <YgpQLnTd4TyiehS/@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpQLnTd4TyiehS/@zn.tnic>
X-ClientProxiedBy: CH2PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:610:38::49) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad0964e-51df-4a60-f67d-08da021bb833
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0198:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01984EEF3D0A280B72380F86F80A9@CY4PR1201MB0198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6IqaajSog7LlfMJfLDPfp4+2AnPh5+JX7ZsdJL0ZSka4O/N4WYpAy4m1j6q3d0+lFv23Kcyn8eEtQJikgktf8/68xbsGJ/2AjhRR7Uap9tfvCBwYditdCiAiI02kvl0rGvwmj6ECnsdCoOtFPywYrgr4q4M0VQg1BQfioIiwdSDWasiFEEt7j2PuHUgcxdeBClsAVI7cRgSbsGmJvlIg5EFwIC4W0379+mkiOcDNh+yOte5lrhe9VkB2exy791tjSuX+OJVv2yz6AsVuTRmo+6JUjUxlBNoQBBOyepAVS34R14q1dMYWpxLeOZv0VkzozcWDcMkvTFr0uf2ykyQEFyeVpnRl99a0SC9aWQKpF1sAug/T2QfUYA0POLK7ccGVHmk6bzb6dx4VDCuCd6ThdXIur0ExO5abs/TIfGWrri9zuGoOznr9ZKHcxTvPQdJKtAFFgVpyAEQuCNQf/4ak+aubXrz2tLNB0rm+nob4L1Gd0N9wRFD6Vk0QPhfjfncADef0hhzDiEpEHzWiAfrz2QVn5zfDyDos4ST3kPvv4NhWCjfqzVq5eOq7VjKXnhrXntXDE8r94ZLj4sHsFJtrp4+9zWKk9VMyvSLYGKTRdCsDUZT+USt7/TJbwHdi/afjTaomKnSCc03CsSsw2bnwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6506007)(66556008)(4326008)(33716001)(6486002)(66946007)(66476007)(8676002)(38100700002)(5660300002)(508600001)(6666004)(2906002)(8936002)(44832011)(6512007)(186003)(9686003)(26005)(86362001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aNa8/fruufm2Ye4W4lF7nmXjPgyTyhM3Fy13FAWxCWIYah0glq31YjrsjeMI?=
 =?us-ascii?Q?ee7vz9RYW1Oa5Cr7PfTmOffQy4jVSsr/vBaFy4LZxq4+wM/IjgHt4gARVL7f?=
 =?us-ascii?Q?X9G6quXV7YuWwjiWATiu02vzepGZkuRUqNA+91EcLnMIVKbCkI80fp36ICSD?=
 =?us-ascii?Q?e1ug4JKGA3+Bp07FcBKQu4L50fs/NhmDx7i/DEkInHLObmzTAKihtpYnEHJH?=
 =?us-ascii?Q?EbqbBtl2s2SJakJMdAMpNcaJJP010yyFUWJnStBb1EkX6qub9vcnLXPUC/ct?=
 =?us-ascii?Q?+PAWAXl/o8cmZcGdIcUbfFBG1ZJhDK49tLKXwS2OgItHmAV0E9z1ilh7Lld+?=
 =?us-ascii?Q?e7zp4T4BCfTVfplXfwHmnA2h40zLA1jQcrc8IyPgtGwnJTfwm/GAoDUbAhLp?=
 =?us-ascii?Q?hvfRGMjFQ2PTdO1ojiRYVFiDTeRvRCsUdgMt/imU483rbh9pTEEafQGTUHwt?=
 =?us-ascii?Q?j4JenG4pUgLj48lv39KtqOUkh+kM796xh0aOodUCmyvHfHwagS/mtkkvfzFI?=
 =?us-ascii?Q?+ThD1FK5bnvXP+HMGdHyEItjVJTklW5AXpitENJ6BnN7vtuCeCGYtOp/1PD0?=
 =?us-ascii?Q?wy/qWIqXS8Q1irjEPB3hFdm866qj/xcc7gyJV7YfoFtpwrUw/bVg2IClmvOn?=
 =?us-ascii?Q?tXYgGaMGRp3fa7mYf/33CAvKeUPTR3aiZbtGyJQJDr/8y28DfG4j7HdFe/xd?=
 =?us-ascii?Q?wW0y8gUOL/iFeBpf0goxL9VbyNFqlvgaXVA2W4BTwiURDH9hgs7uEJLeJoNE?=
 =?us-ascii?Q?nQwPS3IvOflOEx/jpx8nj+InBzkJ66MP+k0ZeVzrA0uw2CDAPy8D/JwWiX2T?=
 =?us-ascii?Q?3XUIS2jqC2hH7aJVl5xCsk/V45sye/AuPTxWoaO2EYIX4pCrBXNG6HJK0aL/?=
 =?us-ascii?Q?VCUFYBhxFsresYIBxy4MNqWSAnLi+YThqcA1xUZ/VZtXsOY5+FFFbXrpPSAb?=
 =?us-ascii?Q?OLpFjV6/mvfRDZSEcbIOjTPUEWzkzoP7IEywyRv2m47MbnC7eCTFLEeqRjjx?=
 =?us-ascii?Q?+w8TfLAMBZwnsc1hyAsCrkb5dSeyGQr1SMbYKqpw/6mc29hw/gjiKfE9jVMT?=
 =?us-ascii?Q?au9wDA55k2qPjd4a1Z5ct5HubY9jXGzKS0/VB3Kpp3C5DHGdbhR1XPMNlOjr?=
 =?us-ascii?Q?Pc+o8KcddcRYfOeuXbY3micu0z04lktkh/vGqT5sVwAs0/SJq047R55YmgxJ?=
 =?us-ascii?Q?N+6mz5DYjT3DvXjW+v7IGncfNQfc1haybB0ez9+J9EW4xHjVhHwqsJZPGlfO?=
 =?us-ascii?Q?E6ZeUrPUFRmR+oBw6nDZs1Iuj6dkPkdNEqDtAnyX/yH0glz6X9+7cyhZOkOM?=
 =?us-ascii?Q?a8LiLsRrHp9FIizK3p/v5vjoypg1fbU3Ft6kcEI2oCQWpnL5fFqMJVBw/J/t?=
 =?us-ascii?Q?GxZr5sFkVW3b63/sAjQbizixZ4MdecwSK6rXGt4TEfRjKUcFHi33U861dRTo?=
 =?us-ascii?Q?C5dDa3jNMbrKxCxL8R+oZou3+oYgyz8d23/7BxIzxgubrQaC7r/8LPnSF89v?=
 =?us-ascii?Q?ZHVccCv5NhuQK5iNxhZ9LgQ4l3egxT3CgyCui7q7W1IrrUTgHfktB54aXF/c?=
 =?us-ascii?Q?KOqIRn9INagyPvYgEpkjGboQJF0VCq4YqC8LoCwTSKhws5QyNYzkTFpFEVBy?=
 =?us-ascii?Q?ouujZb0CxVVgIRb76VStylQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad0964e-51df-4a60-f67d-08da021bb833
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:25:30.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otMbSIIDlyxAXy7Tgr/EHgDML4CmAswbQ8xlvv0l209lfiMwkQQNmdB6eb1A/1mZVsYlVmReQKX6JfR4AbI4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 14, 2022 at 01:50:54PM +0100, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 08:41:07PM +0000, Yazen Ghannam wrote:
> > +static void expand_bits(u8 start_bit, u8 num_bits, u64 *value)
> > +{
> > +	u64 temp1, temp2;
> > +
> > +	if (start_bit == 0) {
> 
> As always
> 
> 	if (!<variable, etc>)
> 
> for 0/NULL tests.
>

Will fix.
 
> > +		*value <<= num_bits;
> > +		return;
> > +	}
> > +
> > +	temp1 = *value & GENMASK_ULL(start_bit - 1, 0);
> > +	temp2 = (*value & GENMASK_ULL(63, start_bit)) << num_bits;
> > +	*value = temp1 | temp2;
> > +}
> > +
> > +static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
> > +{
> > +	u8 num_intlv_bits = ctx->intlv_num_chan;
> > +
> > +	num_intlv_bits += ctx->intlv_num_dies;
> > +	num_intlv_bits += ctx->intlv_num_sockets;
> > +	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
> > +}
> 
> void functions but they return values through their pointer arguments?
> I'm sure you can design those better.
>

I guess this could be "addr = func(x, y, addr)", but why not just operate on
the value directly? There isn't an error condition here that's obvious to me.

Thanks,
Yazen 
