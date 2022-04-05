Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929344F53FF
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbiDFEIh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572995AbiDERna (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 13:43:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC3B91A9;
        Tue,  5 Apr 2022 10:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDZUivlWHHZUzLFHr7aqR37e4YjbyPfr4hAnIe77bP0GX6shq5LldrLmN6Ubq+9oaCX2/K/2wFAYrFELYdrtrOSU5lIqhlvZVd9oMILd5Afas6x8zNBJ06PG9KrfkK1kQC2/lSf8JnPmCAUc2wu172xjVnBISMejGkN7UW4qFky68oKoqtbsk2rSIY7h8U9fYcR6yl7M39hM/WjAvTRCwWG1HIBVj/XOARVAZuWc878SnANWN9n8BSep80ivgZ2kDi2cw79WmyxGGnghuYyLFdmeumTLnfhyLTg0+eW3w5W4yGNT4iWZ86cN7AY1iuETH38fQPXpXBvPCfLOeonEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivyLuN48NtH1RRa4wwVkzzmeC78DirHzhue0sQOJJu0=;
 b=JdtRhz7trgzNmT6bxwfuUBt3WZ8lApLSof0q6C/2kDfjgkrK8Gz6Rq8WLa/3sBTIgjfhO6g9OFR07+9ZOusBmli+bnCWEVIEg1Lb08a3hzvZnI/4BYHpRGRcVmLDnbs6LyTljqMvWgcsgqVf/FRE1123+f16c6dgnog+HiNbTdj2Ac93e/lxNgIadf6Z/UI3Ne2w4DHXR03diYG/AIzudu3A4HqjbYE6+zhTRiXuJCRNDoKLSX8BXMfpJuVBjd/w6sZtfDQt6esq47zpEHn68KCNNuuP5zJkdx4WWVayXznjD3f87gWVkhU5fhn1+ez0P4Plf5wlXIhYBqMbdiqLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivyLuN48NtH1RRa4wwVkzzmeC78DirHzhue0sQOJJu0=;
 b=GA8o5wnczXiuTxf9RKlMcLTZUezrXuswsUkqrU5l8Xb31iUIh9Z12DwV9rGr1zJqJnaN+C4DOR9fv9xgaaNCceIKBRXfEtN7Qgzh9f8DeiADUaAI82Hgx2McAayTz7/SaeLwpCPh0mMvB28r5X/gcgXT6MMOwqv+/95mrtOzyg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:41:29 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:41:29 +0000
Date:   Tue, 5 Apr 2022 17:41:25 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH v2 1/2] x86/mce: Extend AMD severity grading function
 with new types of errors
Message-ID: <Ykx/RYZpKi5SQ/NN@yaz-ubuntu>
References: <20220331163849.6850-1-carlos.bilbao@amd.com>
 <20220331163849.6850-2-carlos.bilbao@amd.com>
 <Ykx59WvoWKi2y23x@yaz-ubuntu>
 <ec7dc7e7-5808-58f8-cbe9-d8fdd2de4c35@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec7dc7e7-5808-58f8-cbe9-d8fdd2de4c35@amd.com>
X-ClientProxiedBy: BLAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:32b::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12fb42e3-6d10-4781-7533-08da172b83d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4252:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB425203ED34ACBF50FEFE2786F8E49@DM6PR12MB4252.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2Wtz4mfaRmXvbLf4tsBlVUeQN+RKAL1rXR1EV+IrlWI2M0MdzC/Ss5GvVAPpll3aO7FxW0gq5F14wspmC79MQjbNXcZUJ+dX+q3gIP5Pr0aEE/5Yzbpri00pjBxm/WHf1oE3Wil1j15HjUzP4jxygWUEAMnX4/1ePzsB2YxB65JBkuFRiYbAwT/oRx1nmrmDoKNoqyrSYHBpCkf2FcJWahkLDzywshKt9aY4WSddvG84ah9opS8EEoZN8b1gSuMLsrGQVnEwlPjTW/QzITXcp3nb0ajIiAq0y+DNLsVZiY9gA7wPzTOXZQfxCIpZSYwlWdDycu76WQ6cFhtZf0Sxt2Frh8m0XzwHRCY0lTd0zo4jfp/ppewwmaj8XPfHWX2h9oUQlgHRMTdm24L4EKrHOj6bELJBnYGSfxjukvpHxPUOd2MeyJI9bWOQteMcEXhuG27PrWf3+6Zl1/4pdCGMeIvtxAU6G2vs1Jz8hd0WlPBJNcJreszvEh6kd9Lt+OkgrlHmXRr4Y74lwq+k7wgUBUhxA6Uo1wLreR1mDR25O4xYVPUZcy83B1y6wnKP+aEU1kRa7s5YR4APJ+LXnDxnQLOTzK2auFEyZUp6XcNQsvkhSPUGncp32V0eIBuJnMcwxU6kc970Vd+nzEqmbS7Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6636002)(6486002)(8676002)(66476007)(26005)(186003)(66946007)(4326008)(66556008)(508600001)(6862004)(316002)(9686003)(86362001)(2906002)(6506007)(38100700002)(53546011)(33716001)(83380400001)(44832011)(8936002)(5660300002)(4744005)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wp8R3/I+P/r8ymHkilP0dMKkPlXCh4FUIVLwVRFLS9yzzKzLXyWSYoxa/dun?=
 =?us-ascii?Q?xNC7OvrbOb7rEPWLjpfauQQ19A9BMv703CH04LcyGt7aehfTjf4qREKiu166?=
 =?us-ascii?Q?lj1IWnU6zft+yZ6pKYTGBlRoqQkQhNR7kPQ3busyHAie3+LSImhvdAd57S6n?=
 =?us-ascii?Q?TNvOUktt7iV8vs8JJUu1MtbXb025RJAuVTGfYw1X9XU4nAU2scce4zwqMMTE?=
 =?us-ascii?Q?p9s02TOPfA0eipUt1mcbQ1uKjjhdqLo3j0hydP+p7uIiddB8CI0H1ZBXdtcD?=
 =?us-ascii?Q?HFX2JUmR4AyRPM3qzfEYzwhwwqK2nP2Tl9YewZ/ABLvHJwnHN0gj8Rb3Y06a?=
 =?us-ascii?Q?4ZBPhsqxmBvCYb6NI1MjtdUkyaeaf2Hd32w4asEhRhPyj8e0pAfC7EbsVDbb?=
 =?us-ascii?Q?Cb2+guRqOaMHMxR30noz7jNRwWTq+A83FhzWcE+KTPhbRwOUpcPXvqK29adE?=
 =?us-ascii?Q?32191C60+aebLxMlRUn19m1EDXJi4NQW899jzP0b8IBqkhGPQ+yThRPb3YIw?=
 =?us-ascii?Q?6oi4qJHGqqzdaxZ43whv9z1+ZGEwnhBQ5U1pA8T2Yx3C/ltTDxdTYYfaboTU?=
 =?us-ascii?Q?GqOD4xBjQoIqslf9yYSA/7xdMDk4/6r+riGNr3XDHKhfnP6WefE1AwH+ElVl?=
 =?us-ascii?Q?cxMglIfGxUE5+cF69EA2kGT9gmua1aZtCwjxOzEbayAErLN6zLemXJY9jF3h?=
 =?us-ascii?Q?TY8lRcseNs40LUyf3PsvWEP1hdcEqilXALIcMvpKAMMJGhS8EF7eNsqDRnSm?=
 =?us-ascii?Q?ticeowW6yHE5PvZ3nofY4GttrDFodMCJt6ggkMbcifZ3b2Bj9Hl3xl5pwmEo?=
 =?us-ascii?Q?s+MKsFDvBv/cJHJiT3br4aXxVfdmNNwZOlao21U8e1YfbHJttv3GmHUU/MmI?=
 =?us-ascii?Q?rHWmmSX6mNXcYW8pobuAIaZdItdYMD9GVfnEWkLNtBT4Kejtrp24A3adykcv?=
 =?us-ascii?Q?OqCYSniVX1jT/QpxCbVKincBIYIlRZOTC3mj6yp5gNuOXM57gUasxsmWAW7I?=
 =?us-ascii?Q?dn7Us5VXc6PIKyERMfOkCre9s6mFIZsJNQysRcXLRbiLv+XQ5/28h+YPIKQu?=
 =?us-ascii?Q?7/Bmk+I00ykh3tlQP0O/OJGUvAEKtw4tzZiLt9v8pd8Msyw/ZbNP9WNpLiVk?=
 =?us-ascii?Q?3Q/hn2B7fDmyy+rOx9WRzN9NfznxLViixVwaX7tPu/dkPUP97Y9sF6Z3570d?=
 =?us-ascii?Q?r8oulUz85crCKIOgC9ujlm5+hsHY7FfeA7eYoe53YqdAvuV3b+hbypXv0D8G?=
 =?us-ascii?Q?uYRGxnttLCHc7z01QRgOa/3+3oXR6SaWwRqIPUQi2kcGv17b7sG2fehVhC2G?=
 =?us-ascii?Q?4LCp4qVb9MUOPROFYwXZG+i0LHIGPO8XIMTZ5ylXv+S4vW+QtxPfbWnCkHXR?=
 =?us-ascii?Q?yjSU4ZHJowB+o82OuayX9r0d6Avb3FbWhp5AH8P3mAIFz8D81MZpi2K+zSI6?=
 =?us-ascii?Q?KlNOOonpV/iXee+dxygU+EAfYWkFRosFkJpxTfJ22M48McFACchfOkA4LPxE?=
 =?us-ascii?Q?MctvJlz0s5AkIGGtpCI+qecQ/m4gow+sv3s3viiT29GNV7rQ2uDupnWyM/xl?=
 =?us-ascii?Q?8ftEAyIUPWKKwbJPuXXci+D6h8cSjH61WFg0UbVGcOvkAg9sNCV96kWeXb+5?=
 =?us-ascii?Q?oMCJJB2br/AUhWWTXQEbV0kJAT4gcuHN/WsJmvK5zLX41WEj3O2KPG28zjxB?=
 =?us-ascii?Q?ZoMD1i1DTtZzdUYGsSX2OIRWUj+By1YdQjG8inNZXnyHlxVRXIXVvM67Ls+S?=
 =?us-ascii?Q?9DXwQDkb8A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fb42e3-6d10-4781-7533-08da172b83d8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:41:29.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1K7wbHUquIhfHAaLhaCLxnvfiHufGoLDgdiuTrjfQEy1ZYgeKIncsQ/ujAKLR5QdlY+LGY/2jgCfjjuf9K8Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 05, 2022 at 12:24:31PM -0500, Carlos Bilbao wrote:
> On 4/5/2022 12:18 PM, Yazen Ghannam wrote:
> > On Thu, Mar 31, 2022 at 11:38:49AM -0500, Carlos Bilbao wrote:
> >> The MCE handler needs to understand the severity of the machine errors to
> >> act accordingly. In the case of AMD, very few errors are covered in the
> >> grading logic.
> >>
> >> Extend the MCEs severity grading of AMD to cover new types of machine
> >> errors.
> >>
> > 
> > This patch does not add new types of machine errors. Please update the commit
> > message (and cover letter) to be consistent with changes made between patch
> > revisions.
> >  
> 
> I'm thinking "cover error cases not previously considered".
>

Please elaborate. It seems that all the cases in this patch are already
covered in the existing code. This patch seems to simplify the existing code.

Thanks,
Yazen 
