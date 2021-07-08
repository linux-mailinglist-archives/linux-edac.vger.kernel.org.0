Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5D3C1AA6
	for <lists+linux-edac@lfdr.de>; Thu,  8 Jul 2021 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGHUnw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jul 2021 16:43:52 -0400
Received: from mail-sn1anam02on2082.outbound.protection.outlook.com ([40.107.96.82]:33383
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230238AbhGHUnw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Jul 2021 16:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1wM0AuU8z8ugMgcVv61X+s2rKLYLkTyHDbGGqFhkoJFj281E/B5DuHFxEkeEoZr8WmOX2fQwpy6R6ce1wlhvAB6XojuoY/W6e/AwiHVkuOjcMpEtx+eH4LIM2nfSCTOx22hbfCGUB3jjAEsiRrpgn1VXH9gJ4BCdpevxESHWfbTiqmDfknN3D1j/JIb2LkP4tYLCh91d9+w1wRE058nY93CXb2v+M3yy9zSP8nIDDaH0t71aTdy/uqcJxPSIVTYsldJWiRpfYEOJ6wqFIQSwyZxOJJkFTlSA/131ZL86wG+5vIyQS6Z/I0wXBUnH+VheU2aVs48krSOzj6KdHxF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnbLuGwQr5VFZ0V7FAN4pEhTxxSwl6YI9CMV+5EOgZA=;
 b=SuuOnCs6/MFoH6ZqiD7odKSM42mp5KssZ87+V9GUF9qiVFVJ8L+Ud9G9G0319utWsysPEnq6rc21VzM90S8X7iu4XqZeoT+mgeWtW2XNBIJqx7UMe+FoQRDsfAUQ3hiQDiUOHr+BbQ+jLqlckYP2doxItC7AdTQeT7i6KpGzQlD7GZlKpYpvJnFpgf4tk3WsHUeEa2k+/Vy2JHAPuoJH5a/Q0s9ZpuT34a8AGitYTHPlE2YVCasq1dDaa5/n1IH2hrveNOxxo4qhOweBOYM2wip3N3yyNxVNVDtqkrXMX24l51GHT28g8BDPnkP7Hl29hA8AochqPA6DKNrYnhxNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnbLuGwQr5VFZ0V7FAN4pEhTxxSwl6YI9CMV+5EOgZA=;
 b=jFOzLIIM495knaiiQ64qRLzw3507H4srUiZwWtTES56YXp/Ry1RquJMcaHAeTbl4OZLQa62p1EI6BQUcao1H67bzgy9OyI5/LRfVH2fI1QdUJMt+KWs2RxTHQa5Izpdeis/T4XY2aqAunvZZ5IqkM90SDyU/3bxrN7x85OHhyRE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2546.namprd12.prod.outlook.com (2603:10b6:404:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 20:41:08 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4287.035; Thu, 8 Jul 2021
 20:41:08 +0000
Date:   Thu, 8 Jul 2021 16:41:06 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH] EDAC/mce_amd: Do not load edac_mce_amd module on guests
Message-ID: <20210708204106.GG15605@aus-x-yghannam.amd.com>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BN0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:408:e7::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Thu, 8 Jul 2021 20:41:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e4da2e-1b83-4bd5-4830-08d94250b6a6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB254601C6F31F41389BA87551F8199@BN6PR1201MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eu3K0aWvj9Aaa6JNafJq+J35H/63C/BnTsgw8UHTmkgKJkA0s+dOHedlYvzewIe0/M5cIsdfUvNtyWHNAsPQ0gb/gHpeMjxwv1KAihQLmyEGTNRREy+q/eghXuOxaGcMqL0xLqwffeF3riNymBJ8qjww4cJDegiuQ4/MU3Z7TMKvTLKMhBUHStaxgz5w1X64thVsOjKXgILXHrq1bc8P+cnyEtF896G9k0q/4Vmuc45BkhPFxX7LkeIik8myny63LPVoo3JNc/5nWKAvUI2YGDv5EN8FiWStCav8yzPhJJPhPCviTaeE+5Sq6lRTmp3ai7cNPQcrgy5i2+LtbworRvPrL7FhaQQvJoE+N8A6zPvJyqS9PipuB7blrs1Yv6TtTksq+QcIztRXQ2IytcztQEcg1eaSdc1Pfre56Md35KivTBP3RWH5RYiqIzmfrftX0jagDv66OsuNjs2aWKaIbOmFmTihGxGXHX+eBWXz5ddG64J9ye39w7DecnRsqsrAbAZVXvilDKKSbfDAXuG5S86rkuBtE7C5R3lBxBFAeRpZlt+rQ/SITD/wU7q9yp1rBzdYYoEOEP4HBuQ9hCYIO9YF96z2brSIKGKFazvpshXBbiegaLA1Ui87T7NldsOappFoFO9cjzjtJOzTlRJjQBl5OhBae+H11LfHh1arz6eQAFF7Lv1TEXNwNd4/fqsqUqGpgJZfHFOlZ9/gfNfLcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(8936002)(38100700002)(44832011)(478600001)(6862004)(5660300002)(186003)(54906003)(38350700002)(66556008)(1076003)(8676002)(4744005)(4326008)(6636002)(86362001)(33656002)(55016002)(7696005)(2906002)(316002)(66946007)(66476007)(52116002)(956004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfQWRuaGdD13VPY32FtjLBqRBcLM5tAwiaLHBJI+irm9WBCQ9gilFTS2LCj4?=
 =?us-ascii?Q?oc/4eSJmx+XdVSftkHFyojr5CHGcK2Vp7ZEYctw8hNssCThGUm+9AsBBfEbA?=
 =?us-ascii?Q?PWNSX9f1Vk2ww7ca0KBWegJlSmsDJqBPayu/RdLkMsXANB4lNu+TYTrlgMRR?=
 =?us-ascii?Q?x67c4DwvHAbo+tqr/nGvaDKGUqFbW2IkgDkrOwgEpjnvT/djaa4Mipq6A1KV?=
 =?us-ascii?Q?Eza3b3u108vaYsFMuYaog/3FD5v/lKvwn/OALtFDYw3yzJd9l1s8/D1U0fgU?=
 =?us-ascii?Q?IUOGaem7B561QjwXnRvFhgA9OQQxZ1exoKcBWHrdmX+v4ljkwkolMfOF2nyS?=
 =?us-ascii?Q?yXWdYiUfkBSDyaQ2kb3JCTuCbBKGjwAGZkP/zWrfqWW7DfmuQEnUHigBNUS5?=
 =?us-ascii?Q?wncqtvj9+fxIpzzQq0KX3K0gZFWRn47RA9/nJNFZ9akjVKwdtuEHIq0a14nz?=
 =?us-ascii?Q?aZB0FpKtEfDS1dUAq+IOC6HS8R4NXZNXRJOCgNIExOPmAzcoLcAXZOOTfeO6?=
 =?us-ascii?Q?NCtr8SAyBlWPMhL6zEZOLwa6jdW4Ub0Obdl2gsNcCqPzJgfLschJAviF5uSt?=
 =?us-ascii?Q?eQyuWHO3ryRLGx0rfGGum5VwRFzqmxQgaDvNLCzQuvZsqLWU8Bw3DFEGm8n6?=
 =?us-ascii?Q?SijvGvPmxZ8prqk/y/qqyGPlf96Vy16wAKU/YIxgZxOImusq8jkXjRS+Ka5t?=
 =?us-ascii?Q?bfRws+Z4SbmPmG2UgVR3obhbH3m5LvHw2quJsPELf0tuL/8H8Ofo6MbbKUIa?=
 =?us-ascii?Q?po2HhvTEEIdvBEEIImnthvcOImMQeG/5gbHVA0twqTzi/0uJQULrj6SbdWJ1?=
 =?us-ascii?Q?M59ny2aJLcyYl3GzZU/rkNYEqvhLf7tjS/9+mv3hOEc4WNjBfQ3Sw6Ws+jAi?=
 =?us-ascii?Q?EEFAUGcAXwey2YuglgG3Loba2LtqvOSJp566tzYq+LFngKa6B+gy9Vo1ClCS?=
 =?us-ascii?Q?kpoVYKvRD+He/9Jnqv8sWhUl4GmeYAzEokOt1qlwcN9iQOktLKuZUIApgXdG?=
 =?us-ascii?Q?I9gEYFTkbWPhbr7FOWXbw9Wj2du6EEUIWFncL4WjeJFWUS/SDUn4ZZBjnGEj?=
 =?us-ascii?Q?4/uy+xdUH5VWLvLjJaRzGZTBugU3UrZhHWpmVhLHDuMLD6xSNPrp+yxBsvfg?=
 =?us-ascii?Q?qz4aJZndDzbq2J0/zeAEKg0+mSRS1d1No/7QfL29ux0YlaC7ssbJSsZONMZh?=
 =?us-ascii?Q?dqW9o4/LGSU5jboDNTNt3QFeNBVBJvnZ/ptQtry0k+XeIvZcZieXV9JH3whT?=
 =?us-ascii?Q?bxnQq0kTU7CggUhnc/m+SRiswEpw56q8c2VZhFhv31WL9y1L0XBurdcqjUt6?=
 =?us-ascii?Q?IQDECSydL5/zFP0TiB6XK1yJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e4da2e-1b83-4bd5-4830-08d94250b6a6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 20:41:08.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbpKCEkbwtZ6QnHhQDSTpiyNIzayS1iNl+y4pqpnS6Jq2gEOrmFCSct/5PNdM2ZcDW4We//NrCUbcE0lui/LOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2546
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 28, 2021 at 12:27:40PM -0500, Smita Koralahalli wrote:
> Hypervisors may not expose SMCA feature to the guest.
> 
> Check for X86_FEATURE_HYPERVISOR on entry in mce_amd_init() and return
> -ENODEV if set.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/edac/mce_amd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 5dd905a3f30c..1a1629166aa3 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -1176,6 +1176,9 @@ static int __init mce_amd_init(void)
>  	    c->x86_vendor != X86_VENDOR_HYGON)
>  		return -ENODEV;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +		return -ENODEV;
> +
>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
>  		xec_mask = 0x3f;
>  		goto out;
> --

Looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
