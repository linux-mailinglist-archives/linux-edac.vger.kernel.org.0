Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B766C6C24
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjCWPTa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjCWPT3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 11:19:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8079C29431;
        Thu, 23 Mar 2023 08:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By1GT2QrbRWJemIYDAOvuhgpNd+Y7nhFOi+cMSDEa3vA5jFf9xPpx4nhCJGMEsTGjCPEWtG+deYQD1RIjEI9wh18AkvxGLjtwnIfa5UpF31OwyLJRWzMbmms/PMZ29eXTNHC9Xh7/v2/byIpIOvmjk1XU/jjYkXY94GVb7r68SLqzSEycMRHE++s/4HT0x6L1Al/zCrFypFSrLxu+kxSbXsJ/P9VuOxaYjmd/82Tc1XS407s/+fMu1uZMJZozo/oA+wDX40fUTzgMMTnvSzLPWVDMZfl6ZDa1HlhgprdJ67wA6pQEX9SlisIuU+c5yYIbgpp7PiPrQNmrx8XAT9h9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oenXe6GCgWM+R3GGAVmWvktYzteMravWFDsI3jeaUk=;
 b=SdsEOahv87czW4hIdefo1iptGLyIKnk0t8sUf/aTmCA3XNOKseK1z65/ms/5Q28//+KhkLd96XYACgCoe2YI27aayBXUkow2eItY8e8a1EAvFpGPbt2Oo4E43M8uJL0NK5VGzIxCbqeVd8zq7EkRr6UWxuqdAiGXL6bWzlf1BOYgPLvMHIxnBbnh88bS7SatzLWC3AlBjn9KqGfANq81M51dKGvtylNTKVRikGnRT/sYQ/jyLg+ZbI5bthO1PKDTcfDV4oRzmawjtsWR6VYA9Oqsy/sTw6Gqsa9LZdSN9kLaqqSSnd8sth1iT2Of+l8D0f4RFbJfylLW8DmZG4AtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oenXe6GCgWM+R3GGAVmWvktYzteMravWFDsI3jeaUk=;
 b=wb9R+rF8L0j1jDejpxNJ3AFG1d6V7KQmNyTyIK10QwL1pEvRn8tkwZwYX3sKFG1hWbIyN859vtZYWu24+sakXl+znkYHQLQpi3Mqn0OZ+t+lDg1cjmVbheuZ/QzE0eImHacHE2fnsAUM4W8ZwFuGFRXhHDTIMvoOBUo3xqpgwsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 15:19:19 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 15:19:18 +0000
Date:   Thu, 23 Mar 2023 11:19:15 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 00/22] AMD64 EDAC Cleanup and Refactor
Message-ID: <ZBxt82FCvOEz+UCq@yaz-khff.amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
 <20230323110150.GCZBwxnh/ekDGPHGXR@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323110150.GCZBwxnh/ekDGPHGXR@fat_crate.local>
X-ClientProxiedBy: CH2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:610:51::12) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5ba5ea-e520-479f-baac-08db2bb1f89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRKMJcV/sa9pIonRBfafuv51gZZvE4JRmf/0PJP48RsWJW7dL9LQnYIoGj1vDjkF+U/pQNYwcZ57i9Ui5W04g9JgYcC3lyuEAJkYhmbqFQMIqPJsi82kEKFNL/4+jypb92bvMDCjeNrYXp9RjC4jBZVrVjNaf+qn68Z5Q9QJ80oOJoksB7PbLMTqyZVe2HmuzrLPd5eRlFvZLId/fFxIpoN2PRCWNgn4Sdba/ds5tqNArP/ow7YYUvuya6lQS1KIc8UwjqU8HnrVimjDqkWtIwAJG93JWGOK4qSOjj8DHV+lWffxjrlx888tBBXiaTkFEtF30xe7nQCqayD2rtiNgfMm6cKC77kWn7QaVAE3O2Mq/kkCjxLnFOi4jGGqB0Uimj+axgddQ2TC+GKP1DWYxPZLMQL/qbXm+aY1mmyCVn9dc+p8WC0QNp/iPn0Xbhpxvl4OXSlu0JC9wyoABOINIAogVN0Rho3KqmRXWOuT1WcSANgWJM3BFFduSg7b0fYR7VDlCSQyXTX5Qt5WE6cxw+6vADMOQP7UUgRjGvxAfb35zQrW3Vuex91vvIrjh8WS6S5Ho6Z7Yh4Pwl1FGyE7QyGlAvFu+QeplzHXs2ry32epz9k5T0nkSWXF04G4qPrtWnO1nYKH0oohqppAa7jms+/iE9Can/+ZfVyMDC/AQMIWE8s4cED8NH9Ue2cl9Ksa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199018)(38100700002)(2906002)(6486002)(83380400001)(478600001)(186003)(86362001)(316002)(66556008)(66946007)(66476007)(8676002)(4326008)(6916009)(6666004)(8936002)(26005)(6512007)(6506007)(5660300002)(41300700001)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUwCyMVDGjv/noPhA2XnfLsi0CLMCmgsebMDzHzaXFRE6t7Pt0i+s3iuOF9D?=
 =?us-ascii?Q?U9XJrY3jiHoOTRbZiNmP2r0CnJPSla/wxksI6V4AWEaCB+usk9PJIu2xAX4A?=
 =?us-ascii?Q?Ue/hg5mbgn7GtpEIqNCz8zU9Hb0079neZJanDUYykCy3hT7lIFVDzca34bP2?=
 =?us-ascii?Q?JMHMTxQgVYF0Clwl1yeJfbb82DtS+Y7MNmPuYHLTfBYotaZqAVaO2LLKq3EB?=
 =?us-ascii?Q?n+5ZJZUsT6W98YLB1nhjALUoqpC3RCrkWXgfg0+yfx+FNd3ACF7Hgja2Y/vK?=
 =?us-ascii?Q?VytdwBrgr/fiII7uEzeuAcBY0+Tkv64fuaVA3RNp2g4ZQGTo8RZ9YPTpXPae?=
 =?us-ascii?Q?jhbQclTcXjvyMMJqrkog4Mu/Cn9gz5WZ7tliXLXm/YLNwKjk6rdG1p0nMoDc?=
 =?us-ascii?Q?WiiOgSjigvTMtgoKbOBaTQQMhTYAn8AnYVlPutNrLq60r2sGjny8T5lKJ0z0?=
 =?us-ascii?Q?75I2exan/92Q98PpPMTNpzXKvv/DUVzoIts/nRAbq9v0HdDN4D4970Yo4qqn?=
 =?us-ascii?Q?gUOJjd6VbhyMA7VNX1UawivQgZLH/keaI6DkLDOrvG52Sj2JgwYcQ+56pS4E?=
 =?us-ascii?Q?qWccveqJq0r1xlpnE4Z0CK7TneHW+5YfaSg9mlbt0bcXMpVyineASE0Ny/7i?=
 =?us-ascii?Q?um717vQ+5vfFXTZ0JDEEFgP35c7AsNjCi1ngDV0pKPPQfi1wZ2lLBx4B/muT?=
 =?us-ascii?Q?zT1iAL3Kl86XSuBVKAhtm25gTmPmo6M9ISPFVpbrXMu9+O5YKkz3klrLOhML?=
 =?us-ascii?Q?pJtkZM28dtq+KLZOtm7uhgJYP5nULzWrKRSpC9G+8R+IgJ+PrpU3gJqh7eUi?=
 =?us-ascii?Q?TN5YlsQfVRoRCfz7hOwLO3LGWH1z3FU5yQrEGri/9zTWLIjgkSGey1kj6pzg?=
 =?us-ascii?Q?c3K2wIjrz/gPodFoMC2RAmTQf7lHSOfsjCsCZFQNpyevh2rubl8nzRyS+9PQ?=
 =?us-ascii?Q?eKkWTIcyY7EXNGsRH+sdFMBeq2XxsVszJ3wvAQOaFX7xhlJQxjySTMSwoWar?=
 =?us-ascii?Q?aZ2ohBbJsGFaYKV2dMbe07rcqdVoRt5xrzdppntTSkHCM0DHq5CoLNlR4+46?=
 =?us-ascii?Q?KESlnFms4cDHNZb2l89n+pyogQyFZs/i64Ege1qp2TtSAlEAaaedlX2UY1EA?=
 =?us-ascii?Q?f0OKxQDH3FjLKOEe44lGFnSuKxv6q/oC4d38H2MPPfjQbFzZy25jhtCjW7Zd?=
 =?us-ascii?Q?anDNYF4cjR4dNLOp7SK51Bb+KRIRxbcfumz6270eU+ZAmCovB+c6sw7X5DBO?=
 =?us-ascii?Q?eOy2m/lk6iBWlgoDJujzN9tS5h/dKrOgDhoisj1Ll0Y8XMaw7GlEHJDtPEbO?=
 =?us-ascii?Q?qB4MNMJyb5R2WWGRk+E1TdpWpQ1hy63OLB/9rU8V1xMSsgVpJTUcMyt2wKFx?=
 =?us-ascii?Q?+d+aUSAnJHemN89vFIJgwcfoAe/K6WNo+9LTPHvHHseCgL1CisYu1KfqtmLJ?=
 =?us-ascii?Q?SFyuy9t7lHx3HBDoJnWBLyH5iyHTtzF22TouH9U2MhulMNEHuw2Pnd2LFSrg?=
 =?us-ascii?Q?Z5cdhBv5UdXlwTO1It5nYsp2IAGd4i5llNUgLbRnl049MKbiyXg0WdLvu/9I?=
 =?us-ascii?Q?GTRtS+uMDtFlYo+vbBGgcOM6ghSwAP6dFT+ZtSZR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5ba5ea-e520-479f-baac-08db2bb1f89a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:19:18.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N055ryi24u7e99F/UlpxBYi8FbwhUMwnuJEwQ+6INuMuvfp31wWLFtOCCUNDbXeUjrsR2ZW/Wre2AJBhDUTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 23, 2023 at 12:01:50PM +0100, Borislav Petkov wrote:
> On Fri, Jan 27, 2023 at 05:03:57PM +0000, Yazen Ghannam wrote:
> > Muralidhara M K (11):
> >   EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
> >   EDAC/amd64: Split prep_chip_selects() into dct/umc functions
> >   EDAC/amd64: Split read_base_mask() into dct/umc functions
> >   EDAC/amd64: Split determine_memory_type() into dct/umc functions
> >   EDAC/amd64: Split read_mc_regs() into dct/umc functions
> >   EDAC/amd64: Split ecc_enabled() into dct/umc functions
> >   EDAC/amd64: Split setup_mci_misc_attrs() into dct/umc functions
> >   EDAC/amd64: Split determine_edac_cap() into dct/umc functions
> >   EDAC/amd64: Split init_csrows() into dct/umc functions
> >   EDAC/amd64: Split dump_misc_regs() into dct/umc functions
> >   EDAC/amd64: Add get_err_info() to pvt->ops
> > 
> > Yazen Ghannam (11):
> >   EDAC/amd64: Don't set up EDAC PCI control on Family 17h+
> >   EDAC/amd64: Remove scrub rate control for Family 17h and later
> >   EDAC/amd64: Remove PCI Function 6
> >   EDAC/amd64: Remove PCI Function 0
> >   EDAC/amd64: Remove early_channel_count()
> >   EDAC/amd64: Rename debug_display_dimm_sizes()
> >   EDAC/amd64: Split get_csrow_nr_pages() into dct/umc functions
> >   EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
> >   EDAC/amd64: Don't find ECC symbol size for Family 17h and later
> >   EDAC/amd64: Rework hw_info_{get,put}
> >   EDAC/amd64: Rename f17h_determine_edac_ctl_cap()
> > 
> >  drivers/edac/amd64_edac.c | 1221 ++++++++++++++-----------------------
> >  drivers/edac/amd64_edac.h |   89 +--
> >  2 files changed, 483 insertions(+), 827 deletions(-)
> 
> All small issues fixed up and applied.
>

Thank you!

-Yazen
