Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E047D694D7F
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBMQzU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 11:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjBMQzS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 11:55:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5559B1E5D2;
        Mon, 13 Feb 2023 08:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZSLW0tGA3Tv3zjBT69z13c36aUaN3ThHrmW4lJkKq2NLEibjCG1RnMj9/RTkqki69PBg9G71WBedgQFJN4IVc2LjOKrLqGOiadLhs8Y7MixhfNZoU3AYxOcIRoCDJcJ9qhEvuROxc4nj9F4W2V2dt4biuAbU5Hcx/YAwYnJzfqdHN5u0FsDylBeIVqhlxlDA5a+61vxK3HKK1oD2e5i4LGHbCpqD8SRvtc42xTbRQ+06jEAriskLh31i+XFmr4PUm+76D2LYXnaNTbb6tz1PRqs3ALrXFOjjQmKbwl3jyYX5btkDoM4Du3ybmBA2kJgxbHJqJck/vNgbwhgtS+pFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZJ4v95JuGMxx2sGICTJNFMGq4y8Neb86VBUtjqcVyw=;
 b=AakzbVl0qiUewaUDw+MZLnbynpfbo9rIfR6dtuHcn9FuNYx2F+ldFL5j3pWTwuah46BGh4AHm2cCUW3nxdoBjU6SBV1iy1VTfSsYu7wsghkCJY4shQCrJfMTqK17Jo0tgN9yB5Ym+fXjQwFdRq9p0lDinUYWasfEsMRKHLNFnoYWKDmhsCvWuquDwLYlj4zlZWgsDKGFjCvc07xgpIrZvRMytikJQp+jBiqjWdY1OEnecKtCwEN9AzSJRNJlcxaAExB0Q2lfc75aIc2Q6ibmNgYFVvB/s4nuXgTsGgermRR6RedAn0LhAmCSMSYibQW4bS3nUZZmBUckZFexd/67fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZJ4v95JuGMxx2sGICTJNFMGq4y8Neb86VBUtjqcVyw=;
 b=Fkrp/Bdkp3ABbC4KCdYoJxhVLfa6rllpIjSB/hIni51iiNG40bzQPT1qcRxwKGaqR5B2/6Sd+BRhCayTsTs4wH97vJXvXIfGwcPWsDMa+5RUW5Vq85Guan552tFs8KLaXrrPscWPoTv1u+vzlqe0FM2knBZR7NRPDBN6k6KKGfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 16:54:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff%7]) with mapi id 15.20.6086.019; Mon, 13 Feb 2023
 16:54:24 +0000
Date:   Mon, 13 Feb 2023 16:54:20 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 05/22] EDAC/amd64: Remove early_channel_count()
Message-ID: <Y+prPFcCVkqukzQV@yaz-fattaah>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
 <20230127170419.1824692-6-yazen.ghannam@amd.com>
 <Y+Y1nfLOG20n+zi3@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Y1nfLOG20n+zi3@zn.tnic>
X-ClientProxiedBy: CH2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:610:54::36) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: f786c689-fb3a-4855-ba0b-08db0de2f5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i5GnHx1b8Yh/gfddmKW5EusC61O5D+qiZjpwY8Ojzk48HY6mFu1TatTDQGR0IdbUPaeHvy6466e9yT1jIdt4z+DGfqSp/qJPYxQjwSs1+tCFMRFvW1JARlUY2O9a7EqilpXhBhBYrozAqWz5WPPOIgRbqdW+G3a0qkcoloxHJfNHcO+ESk4uXFf87CbLVXXQ3t3ReMoYzWfUHB0K+1mP0RkhpPsFZCGfiDIEdzLXDI3kV0YYtLpw7zKjBSBlYfk71khyktun87gdrGcdF/LzQC7dWdH9DFl21oMC7gJDt28HlareT+QGvlsEpVCpWGu2h14nNbllJ+92Vdb8Tod9PCqfwxn2KFD6eO3j7PkpK7zCQPVAvgjwWswowaWe5hZBrS94AMxIEGUWAMEccag9ro47N6fYPtj4V3IxMnZP0ezT5HywJbw+jTK1oNLfQYJmJL806nrBL/2MdNOsKN0R63J8aTAmusS45AXCO750/WKSkr78XrcyyDD965t54pnNLV+t0cyh1fS0b4mWRqx86+yeXUKwWWMVwY7PWM8DUmVOWrkI0Wi6Mvdu/6110hghkc90TLBkbuCADuIj8eknnl5boMMnQa7RIMHCR2wL4qPoc5NPuyRGJAH4EbVUndS1vtV/3TPpnLXwsWmYtpMGLZsu0yhxNxvs4ykkyJuIfvLI1eaz2ajOWq/DBbUfikL1SvKnY+rB7Se6OBuO/dp7E/W2rvV2RhxDfW/LsTNDDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199018)(4326008)(6916009)(33716001)(6666004)(44832011)(2906002)(4744005)(66556008)(66476007)(8676002)(66946007)(86362001)(83380400001)(316002)(8936002)(966005)(6486002)(41300700001)(6506007)(38100700002)(478600001)(5660300002)(186003)(26005)(9686003)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMWgk8LucO0NoigMW3hwoYT7mr/k0SnDyjuFJp2Y/n6jse4VKmW7LiokbGGE?=
 =?us-ascii?Q?oQjS3R1XPekIC/Bm2FtEIb6UZEc7F1L9bkkPsACXPOyzZ1C1TBaIhY5r+lUD?=
 =?us-ascii?Q?82ERh4hckc3aebCUJKZyY1jc06VDcpmQN43cWh6+DkBc5N2bcniLE6t0N+Zv?=
 =?us-ascii?Q?6KIQMqre6KQ0jmW0iKXf5MhGiRzGwn85XYmJJ6F0CW6YUbL0ZM+Kuc+nKZM4?=
 =?us-ascii?Q?o5EwjUz1Hzil0jDLAJtT4RIGh4Z4T0veKFeLakkHOKyf84MhrLX6erySKpL/?=
 =?us-ascii?Q?Z2L4F8bUhBhEj1algyKIhFvET9OAq0O9dxZoOwmcH7neYohp5eH0M81JvoV9?=
 =?us-ascii?Q?RdnMfDLjAuRgUuqR/Kskib+Pzypr/5ixxMshbBLnHPq3qo7N9fRM6BZsmrQR?=
 =?us-ascii?Q?AHp5CTAvwc/UH2rgwHWc8BWEh70rahLWRrJOWts658lzgcjfese9naOz9zgo?=
 =?us-ascii?Q?QUN8WdPTXUPGHq4zyQWDF5YIwMGXpB4/UgHV5YOFj/SsfqOvTm5nXNbUkZgs?=
 =?us-ascii?Q?JzS8+X1QXyie0jMARH+sUAD4Qh9Bco0xC2fm1P1zO8q0PYNpr9nFxq7N9g7A?=
 =?us-ascii?Q?OAEZdfIXjMjgzCPAoAxrvh+xpRwXsYvJ4kEacrTe6ix1PusMRxQppio74SlJ?=
 =?us-ascii?Q?u4dsOmRHFzKoNgr4cOQojVN2MztBcvcAUyLpVqLVnw0LR9GS1QGPXLonfmVw?=
 =?us-ascii?Q?o4IwUlxqYWuyOOXNGPuMNzR/Tp/NGD5mzYriJg8k0SFUZntX1tiqCXm3v81I?=
 =?us-ascii?Q?Fbj6EJ7xx2h0R/CRZctKJMhIB3VHwQhjYh5tAj0FK1xfIRWO0TUHcQ2nE0v0?=
 =?us-ascii?Q?rMStXAoX8dkUhW15+nu/JV+Vrvhd4ME3dpO2DK+FqYJNJ0qcBdFDrha0p+3Z?=
 =?us-ascii?Q?VTERCBkdYVmG/wcuKli3rqs5TGehEq/nHh+Hl39TSk71bc2y2I73wpZI/rGo?=
 =?us-ascii?Q?alzyazwlzh2XEMO6XsABJvRVA8Sa2pEp4j8i+id5t/QTwOHUtZxacDZtma67?=
 =?us-ascii?Q?auWnCaCKNE+JACqS4rEPnI2jTUc3L4iyjhDQSRaK8Amyq++fBldD9ml8ReVM?=
 =?us-ascii?Q?FEaoxq+okP/x5Q592tKRxGIF0HLNFT52fNNI2VIvX3C1Mc9pRebjN9tfciiA?=
 =?us-ascii?Q?E+RqXQO5buCg7AZvonxmdU1x7T5B/rFZeE+PG04Sm4HV2kl9N84J7tqBp29b?=
 =?us-ascii?Q?qiUm6MkTi1Jt6/G1b+kENJEsuXj7XFTmmVDZwhbPN98Psk9QBmQBSCrX+bXU?=
 =?us-ascii?Q?NWPmUNsmQPZMPonuITo32U547mh7BksH431I06rI44T/VwbmZngk6AOdJ3AB?=
 =?us-ascii?Q?VXACLTxqtuOiEhPbpueoLIog1MyZH6Y6npzg1mluEArUg+s2olGiVZcDRmEs?=
 =?us-ascii?Q?HnEaSUFiw80iRAYPFCndng12oB0pfW+kWYdgWaiEQ8MI6uUi0pJqjcvQS0LS?=
 =?us-ascii?Q?XCHF111glV2VEY1nXh+F6ReVsOReg1nT6tid6FM3fwEm93LP4zTxBXMzxpl7?=
 =?us-ascii?Q?43aTWIf1LuYxDSdgNUquwV+RGDhbeIp81sZB+00RvwXBnGmLZi7ZSLeHQ00x?=
 =?us-ascii?Q?euxsQHmPUvU3+rgzrNYbxxE2KASJf6TnnU54ImUw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f786c689-fb3a-4855-ba0b-08db0de2f5ce
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:54:24.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXI+yLAvYZsjovTBXpxY5l+S2WUxrmKj+63I913OdYmMvPC6z1eukXp61thjrkAk1XWYdnDI04iIA6PXVlEX8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 10, 2023 at 01:16:29PM +0100, Borislav Petkov wrote:
> On Fri, Jan 27, 2023 at 05:04:02PM +0000, Yazen Ghannam wrote:
> > The early_channel_count() function seems to have been useful in the past
> > for knowing how many EDAC mci structures to populate. However, this is no
> > longer needed as the maximum channel count for a system is used instead.
> > 
> > Remove the early_channel_count() helper functions and related code. Use the
> > size of the channel layer when iterating over channel structures.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Link:
> > https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com
> > 
> > v1->v2:
> > * New in v2.
> > 
> >  drivers/edac/amd64_edac.c | 116 +-------------------------------------
> >  drivers/edac/amd64_edac.h |   2 -
> >  2 files changed, 2 insertions(+), 116 deletions(-)
> 
> First 5 patches: applied, thanks.
> 

Thank you!

-Yazen
