Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28E047E89B
	for <lists+linux-edac@lfdr.de>; Thu, 23 Dec 2021 21:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350194AbhLWUES (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Dec 2021 15:04:18 -0500
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:31712
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233073AbhLWUER (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Dec 2021 15:04:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTyDlmewFviTyv1CMOBLjh8lnxjUzMHw40nG16R2lXfjKL3EjvOwC2LxqDFuNKRk6QErEtN6FLIJ8eYMbsi7gp7rP4g1pDWabwczuO8Pu60H7YtIpIZs6WntISeL6tsjqpv3IzjtDu8nb07WOW5wP/BRbKcnGvjK20z4UcG67kmoVgRP87Z7IqrZoumN+YmbMYBqL06qpnm2eZPzzCgaWtZfcHpwCIZGOzZ6kML7PokNShhv7JbpCH/7mwqCPxg2nsFuL1mywrxuujcBWmobj9Ubagv8IMKAEdv4a3lzJBBVFu7k+Akgh1K+3C5HPTc/2cxcxyk11D6q4KaG1EZMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G03sTLxbP9GsIYhQN34PnyDztGINMRcAkfOOAWMQSV0=;
 b=oSWLUftfkh9uDT8fwHwbN0TnRKsEZdL/EDoeP7avtw2NitQWZflCbmh5zgjLw93FF6RoHBhTN5gj16WxluDDCZkbfDgvlgmzkhoW8mb5R4W9YfrqXfg4b+3pwOf5ksfmNuygGR/iDzYwrwQcb8CSaD6GGngpTo0SuhEO6dywVzbPJGiFVP7u+j85CuAdU1h1HAM5Xsj9YZeOGGqzdLRiBuDumoTcajRcdExu3vN2VcRc1NM7NxjjRmviFkHFnWa+agGFTpirn+xfEpMHn7syBwcTlq8zf/K1cnlNgksOi8hh4wf2hQ+At7wsBv7ln/7AdyR3jUTD5+LsII5nTlPdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G03sTLxbP9GsIYhQN34PnyDztGINMRcAkfOOAWMQSV0=;
 b=woeDxD4FoKllT4qm07TFypsQEoilKqY6D+NB1RhqwauUWi+x9yXK2IVj82TaCyN3ybQy0+l8BDt9CVbJh/5hyKLH6/EHJIt/V4QmgBftsVz+GZgYFfCwYJiORYlHmMlKc+2zCX5g2bXtxJsMAIHTGR3YniZvaEiEEPeaizeq+p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3106.namprd12.prod.outlook.com (2603:10b6:408:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 20:04:14 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 20:04:14 +0000
Date:   Thu, 23 Dec 2021 20:04:05 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Marc Bevand <m@zorinaq.com>
Cc:     linux-edac@vger.kernel.org, bp@suse.de
Subject: Re: [PATCH v2] EDAC/amd64: Add PCI device IDs for family 19h model
 50h
Message-ID: <YcTWNfPSadyeHn7V@yaz-ubuntu>
References: <YcIk4XJaBZs/aihF@yaz-ubuntu>
 <20211221233112.556927-1-m@zorinaq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221233112.556927-1-m@zorinaq.com>
X-ClientProxiedBy: CH0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:610:e6::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3caa03e8-8bf2-4bf1-5c01-08d9c64f64b6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3106:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB310697AEFB0C1952D7E0A2A6F87E9@BN8PR12MB3106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+P7hlyBeLlhhlT5/X1AA8+R5E441GM/A9vmgvAIreVMrrfVurhBDAHpEUL0grM4bXyQo661r524kAOMd2bQ9RCH1GFKrjNEAuMZNO6pbsYH6oM8N8jTsmpiN9RbRCxmDDAAtwPaDwSF0UdztdeJ/3Pi0jf9GcxrF+iyIoo1Q8k66yOpQwVe5UFHw6JZ+H3OekvWwwkFEFgH5c7dpaYk8iVXxY+c8KD4UsZmY6scQIMU4cCKAF2M7NlZbYuFkpNw3zSPMIisaHi6e8+0h7UtRnKN06xjlYSsfnwbaq4EqfPlwRgWweVin8wUkCuFwojfld8BDs92Ms6LwZAqbuTaL1S+TpneTgb0TlwcpUQvQYsdaASVQEbcvqe16cnv8xZjtaLK9tvMf2GsF3y35bzdDCHi660CM1WPI+JyDyeqCP4TTNoWriPRMYMnl7c4cYk8X4P9vawvlTegLq6PqsdcQGrBPz90670kLvfT0d5DeIysvkJ3S981WXpgCZtMMce11bSGO2iXdkOGExln638pcdiaDtLHZqQDkdPrWDvGpSzZd1LNRySIiXNCeMaASCRPf9poNRYs1vasUV7KCWltcQi/AURZOHmcfh5aIRjertdOgdLwlARfhVtSG/Ejbm0/FS8huzABTnTuUpgIMNDWgZ/4ngUYzLN9aaj17f0WeALHqDH/0rmJcoeGamm3I16OJqLewjikMIRqv/xcqcMcQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(4744005)(33716001)(5660300002)(66946007)(316002)(8676002)(6506007)(508600001)(6666004)(6512007)(2906002)(8936002)(66556008)(66476007)(6916009)(44832011)(26005)(186003)(86362001)(6486002)(9686003)(38100700002)(4326008)(781001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ClFPy81/y0dkg93MkUlc0RCPCMXYlZFz2ir5N3TQYv0fCeFXx70wm5lWrCZH?=
 =?us-ascii?Q?l0YV/2Q0CEpbcIW5G544xLyAeidjFv38k3dHZwtYjMi5J2fYYueSPcFyIybU?=
 =?us-ascii?Q?IK4iL+Ado/Jr7aABooFmg0xeEE11rhdHMKM8SvaYLyWVTUnrbFHo4klDkeK+?=
 =?us-ascii?Q?PMeLEZ+2VeIrt5dzAdvQ7iRHSQm8eQacoJO1seKCFDXUatZaD1lCG0ruFe0n?=
 =?us-ascii?Q?O09ZSk51CV5uy3rb/P3RC+xh/je4S+S7SYrGuuSmJ56SdkgxqwpnVr7YgjKj?=
 =?us-ascii?Q?SHFZgbFJyRQhKXBYTLRiavDhX0v2sSUukEEL5jfTapuvLTqjqXKK0IJQW5MW?=
 =?us-ascii?Q?7l0aDyDcwdnqnhR+T/ELh3TKq+Csj4sMWTWp6PtseYSxpouG73dGHsfONuQQ?=
 =?us-ascii?Q?z7U//nZrhZ6g2nceefK3BfsG4ddi2DhzSODBb9mmlfhWfWoP7m1UR1l+0Zym?=
 =?us-ascii?Q?A5N+lDGgdnxEIThWD1KCr7MQwcjcgIuIUeTaV7Y8TjRdsFvwfouLm6QpFUQv?=
 =?us-ascii?Q?7C2Qv+o7ffMdjvwAMm6X7ZX/63hR/4kl11jBP3yjKtjiZzTsc4mJUciUM5Wf?=
 =?us-ascii?Q?62zBuH9ZugqXSwWLbXE0kPhT2hmyuJDcjOoEfNvQMvzn5+21getWHRjanhLe?=
 =?us-ascii?Q?JT5HUnNVr/ytqUz9qt0XTFG/lQHZCVxVOPO4Ij/CS3E/acywiplfZFwOCL16?=
 =?us-ascii?Q?zOGLUnDt4qeIpOcTXwE8a8HIYjk25K/d5dD+mJz4dn2K2dJAf3qJOBnfMq8S?=
 =?us-ascii?Q?YMp+4Nt08brddp8A4cNkNaYtJo81ZsxMqqMPHSa1KTQQ+UnjSBr0iOyzhrIE?=
 =?us-ascii?Q?468TRODe2yo64Bg9sWDojMjVh6LjKdN3DM3oMmceMpCM4LccvEYQe7NdP12a?=
 =?us-ascii?Q?f7K+kZy49xIz99eFgrdeyEDcA8qVPnHMP5EtFb+OIRFTOxIuzOmY9pXPtqRl?=
 =?us-ascii?Q?rEXFYh+tGP8vpH+4pKCc4I/woAGMrzPZ2S2kJDc9+2PJAOcXSlamQ8IFNSyK?=
 =?us-ascii?Q?ru9rjTEjDXlSlnyW2+ckn8lBKXyAQqMgqp/O0NEyaZJxZtyrdamzPI9viHZ1?=
 =?us-ascii?Q?02zN0nm6M5jaX/FexDhqedIT23LXheP/od8RCPKIIDS3k/IlNcpJ/ntDlbW+?=
 =?us-ascii?Q?GRMqwlH3LMLl00EZgH8jwlz0rOMFZJS75y9zpxiezbyhCZ6jbGX5B0/sJmHA?=
 =?us-ascii?Q?WPJpZxaO0dMJ6/8UdbgqfUytjsyZiJFA1QT3kn8rmhDDcA0J6/0t8S1Bh9PP?=
 =?us-ascii?Q?oNaTSQDeFSoUZRgqJPsIrUuf/NCjieFJu14a6sDO2B6KCFk6eLJ+QniadCIf?=
 =?us-ascii?Q?kX48blG+367A5Rg0RFrowcuFwMZL0eqBZjfaUX2oi2TZOO4MtXUQAb0ZqDet?=
 =?us-ascii?Q?VCWC0zR4WzTdbP28UbWXm7evh3aYeRm4iop8iBUPWXLDjL6hffkCmplcLmB0?=
 =?us-ascii?Q?MvzdZ6oES7WTGscmzF7+mv4IN/3lqHgSWE+PKQ6aLq91H/vthGpda1T1UmuB?=
 =?us-ascii?Q?JTi+70tork1g4Xv6xx77CJiNt139MTw9ZD1vtn3+VKULf4xoZ3ZpuK/h4dsf?=
 =?us-ascii?Q?Ui4cfsv/2oPw9OEdcNqLNTU2D6yvDd2mvHX+fUTwZpyd1EGUZBy6R+4w4O63?=
 =?us-ascii?Q?5KYAysTsPdeceoobF5fqkUY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caa03e8-8bf2-4bf1-5c01-08d9c64f64b6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 20:04:14.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukE1gRVbfd3FTX0JF75du5gasM3fgCvefVhjQxak8asTOiBeSpSoeUDyTcUjyb58kn+Wtea1GnuZTpIu50QtSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3106
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 21, 2021 at 03:31:12PM -0800, Marc Bevand wrote:
> Add the new family 19h model 50h PCI IDs (device 18h functions 0 and 6)
> to support Ryzen 5000 APUs ("Cezanne").
> 
> Signed-off-by: Marc Bevand <m@zorinaq.com>
> ---
> V1 -> V2: rebase on latest ras.git, apply to models 0x50-0x5f
> 
> Hi Yazen, I addressed your comments in v2 of this patch, included below.
> Cheers, 
> Marc.
>

Thanks Marc. It looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen 
