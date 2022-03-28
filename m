Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5331C4E9C68
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiC1Qlc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238469AbiC1Qla (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 12:41:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098BB3CA6F
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 09:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKlHX/Tgm/Oahac/g8ZW4Z1sZzplDHdYuEA8ba90B16O8u6lsVAHjtWkNCo3yeT9FCkY9PPKnhRHo7HsChbtRLTHET2Uztq2McoKzGTIMhbZy7t3OsuSCKs3aGGyqkiioUSrbPDogeDYyNup+iHOBil7CVFY4kd6C2WiBFcjzjLfGFtiNa6R7muTq8heuDVRJDE4qfNOCNfb/1hzEZJIP6sSkz1fqVH9thDPy4QlX8R5673dWju+lOQfw6VLXuXbZVQGq1TF1CnOQm2Jdufj/qTmqV2uo4CTnEYrH3cfxLXW2IvIWbeJSxBszkLSPv/CqwEf/TsdAzknvCpyp9wHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r13H9Z2UtYSKsPtk7p5DZoUP6ojhYSk19iyWb9+kj0=;
 b=Vo5fjXQi72whyd+4JjSAlQBz0WpxGN88GB/FBvmUx45YXQU0FaJhTZScZLH6nFZCLYmcsbrJSqGmYR+HG4aruB4Fyl9rC4Cq2W2FZeq7hBBDafwbd53boeE+IkYoietl0dxx4AtAI1uG9MFGJgBAm0qO5397zGU+eM0HKbY5Y7mNBPDk8vtvizVUp7I9XTsOlOhqE/pMJ2EhxihtWKKXJv5vEULS1s14uDS6G2ZErDpNiBYcfBGefeNvSscic8LgOx1lQAr7wDaI150XAEkNC4FBefWnTIkkiwuC27th6bawzWxZQMC7Ah3TkrMI+NWMEaSoqKFtIJu4oNXP7Ecuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r13H9Z2UtYSKsPtk7p5DZoUP6ojhYSk19iyWb9+kj0=;
 b=DyCT4L1IUVMzguqVXRNiU3ngCQexx63Oe75Mt+5WdNMw0rOY16YSKrSrzawWNgaBXbbZpOsOPWVkxNmkoOWInGPpLzwPJ+qd9VWtXdtb7qqQh6kWV3lhOK6XhYLTXdXyjJ2PXgG3afR5rD2l93S3TVJW80h9jf94XdWzkAdhqYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 16:39:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:39:48 +0000
Date:   Mon, 28 Mar 2022 16:39:38 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 10/14] EDAC/amd64: Add setup_mci_misc_sttrs() into
 pvt->ops
Message-ID: <YkHkyrQy7zFuwci4@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-11-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-11-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edfe04d9-44c5-45aa-d429-08da10d99285
X-MS-TrafficTypeDiagnostic: DM6PR12MB4171:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4171F41369DE60BA5FC4F43BF81D9@DM6PR12MB4171.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uXtgmQp1VBo8RlKK83QGz7ADpUSqnrqL/7CpMGDPgyULRYPUagAdj99MllLIZXor77QsRAo2EaetgYR24NchcoT15Y226wMBQBLv6s0ywPAWFB6TBLdbBiWxRh/s+F6VcuB9QFrQO1DfdXn9tFCmCc+o930DzqU6criXQSD5BSjUpv0yxiKur4RRfi4gOM8L4rUH0YTUPwmt1FnIA/LjJo3NuMrHS4ThmPmBbZVb2lPa4RTwpaR3ckW8WUNXzusW/0kZsnDntwFeRn+pQsAHhd5wEgYa0xjeHWjDf0LzEu95BXCyL/umzfGMCzkpnB2dyfcKgQhA0P2Kvl8YtEWe0TWvs47fpZGQzsn1jdVH0fQ1lVjaM2mBDo6S89ZuYL+TEcouLamr3GE1yBmJ/iIskkN5SKYreQautHHuuSB9McHVyuKixqMlEPa0vAftwsWF4BP9lZWsWGeddt6IksNI9XAKDT3COTlwdaoS2GfvYbWh7p6bvQJVLEEsUSRkFjRj1YCu203kA959DVuAWdV15ExnseJ9Su9idFYD+l8i+m2JgX0rMrP7tRYEqpqGPc9Byk/O7XNOVtcbZoOSwjZLqIidIcOfUJHoq78FF+Dt6fLUp66AQSJmMyO79To+oIfEimgjDOafEygyEmxVVqXqi8iI2DkVKoqnIqGfYho0WvquPC3DL6mUhuxZKvLXySrkYGAKKukdjEwWaL15p7oNA8dwfQhTm/kzkPFwhwe1B0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6512007)(9686003)(44832011)(2906002)(6506007)(186003)(966005)(6486002)(26005)(508600001)(86362001)(8936002)(5660300002)(83380400001)(33716001)(38100700002)(316002)(66556008)(6636002)(66946007)(66476007)(8676002)(4326008)(6666004)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0RtUSDPmjTKoqXlbrw9lMmB6hg1sz/MtJHeX5VqTXsuQWsJhgqWyjrVjNU+?=
 =?us-ascii?Q?Gxdu4qseYvQulx1REnsMkdOt889fKM3eCNNWa5G0kw2b9y8eZKSVsE6NT6bP?=
 =?us-ascii?Q?p6vsRshnSXcifgJhW3f8CT2bDqmDmBrmTlAENLRd7sVucvJVzR9JDcICVGfR?=
 =?us-ascii?Q?17H0o08QwXI0UeCAaUz5+PTETvKFPskfzkTCjNUmXFyAamT5E4t+Wxeu/0Yk?=
 =?us-ascii?Q?t8ppSzzvGYAs4CZIdcgHrLc7eNpb0BqbuVNHy4wNE3wwqfPzIjROf7rHSv1q?=
 =?us-ascii?Q?yVmhQHHWE1i2NkcKSxtsdkKiPoWUD0jKgu/cZiijl84uEGVRrzGdwGtn0tih?=
 =?us-ascii?Q?0LRIzWUD39yPJydOr9J0Fv5Ku1G1KuVHgbmPgIj9BrowqIqFaDG7XZwXiH9a?=
 =?us-ascii?Q?lj0WqG4L5MjR8qftF+636+OwWCstxp3A5fc+3EYCK+TWCWl6J4t5jLcwbJWK?=
 =?us-ascii?Q?Rqx8dqlrIBMX4J0cFgOuUytQYBbfE1XYjqzJoxFFugqtQBymgVd3XCnnYwBN?=
 =?us-ascii?Q?0HQwilLVgSSk030/vPtCKaoV6pR7ZBj6CvqYQmn1z62vr0rI3VuXfmwSooAG?=
 =?us-ascii?Q?gyyt5wifuLFOrkveGTDQkQVWBENXhAppRcL60bT8VQx5w+pakAHfLwQh8ZJc?=
 =?us-ascii?Q?Kf5/eTVcKQ7gJvtWgE21kF5W1t6ei8FcSntJH6tBLnh7a2gbGUWnlQvVUBkg?=
 =?us-ascii?Q?QL9PcCqBNHEvtUXK5uq8zoXsXbGbPm/kF27M4BCeVZ5HMgAanf0vEUXmYu/9?=
 =?us-ascii?Q?UbDenWJyV/D5gRefPBCXTegT3wIIO/+GkQrBl+LWslUvZOSc5/8eFWuBOA23?=
 =?us-ascii?Q?+Oug2hCXhKCqTFIB4/uvTe0oie0WSp0UaWw8CGCMNRQPnuFwQRhpfG4Ls/iI?=
 =?us-ascii?Q?RSjlGxuldhxU7LLAVkV+XJHcOSh8gGks7yndTM4yUTrcuPTUfZMDBgiXxAV8?=
 =?us-ascii?Q?oieahWoWye5JdtDEGTOTDoWTGPv9w2lbY+SYG/jdErI6QVl9Ehsdjy8yVAMl?=
 =?us-ascii?Q?rCVcnk5x5h2UnHYNjqqJpKyG1765e9ZeGydQAIlD09rPbdoL1Alr85A3cbt9?=
 =?us-ascii?Q?NxUM8df8xW5/e6P0rDWTxac2UipBmswPBuD+t6DSIgNOxWEvbSnhjnBadRo9?=
 =?us-ascii?Q?0bQNVlnX79Euwf2+fRI1+k4eqVj4vaZwU8x4vvE/zArnNrAy75bXNTNcMVnE?=
 =?us-ascii?Q?sBvZ4+ZSuTVoPhxhnqV3udicKqWu0UH/0XrBiP2CzuoD8imG/AOwU2ZPOZXP?=
 =?us-ascii?Q?++WoKh8IA6c6ABuLT8ga+AoLKzf2I3I46MdXQpeOaXk2PzdYKZS2DIGn0dhW?=
 =?us-ascii?Q?PSdHHtSDnu1iFoCQmfGePvCupDzbIvXPfRnszFNAisUaR9WdisDdqqMbTts3?=
 =?us-ascii?Q?bEfFJsx5ydCKN8nxw57KdIVa5E10L5y6j+kIGecKHWzYnqnrKYqtF/tlGRwq?=
 =?us-ascii?Q?Vnjize0rSgOQT6wJiLdNoT/J81Du/M+F6uzcCgqeJJ8zz9sfo7Vqb43Muc4K?=
 =?us-ascii?Q?+F3DSRzEXThaNIQygcY9HA0CBy5l2SAAE51zMhVQvoePtGlSQVwMAw/FSH0/?=
 =?us-ascii?Q?QtxQaiXM4kLjQjnE0lT2lQ/rr8fLTdbeD3889jRbQNbfKF7LZ79upXP9y69e?=
 =?us-ascii?Q?M3LeMJ/Dmr76ZPFs/hrn7seBBFZ3u9W/zOUZOhx13KwSkwgzW7ZBcGw4ZXWt?=
 =?us-ascii?Q?Kmwp9eygYZtp9oKyU3CX/XxMrlk9BMKBRMlLdcKBjoLINO/fBCt1gWUjqCZD?=
 =?us-ascii?Q?hSO14H+N5Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfe04d9-44c5-45aa-d429-08da10d99285
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:39:48.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBgsKn2FWkWtyJT40OGJVNoWwc1y5aUl5QF1DNBrPiwRTK0rgQSaj54DGRvFnA5P/76jv1F1JTO80JH3keuX4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:50PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for setup_mci_misc_sttrs() in pvt->ops and assign
> family specific setup_mci_misc_sttrs() definitions appropriately
>

Please include the "why".
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 13 ++++++++++---
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index e3b0a0329f43..c86674c3238d 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3756,7 +3756,7 @@ f17_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
>  	}
>  }
>  
> -static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
> +static void f1x_setup_mci_misc_attrs(struct mem_ctl_info *mci)

The MEM_FLAG values aren't correct in this function. I'd like to say we can
just not set mtype_cap since it's only used in a single debug print statement.
But that's in edac_mc, so maybe some users expect it?

Thanks,
Yazen
