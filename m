Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CFB694D6D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 17:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBMQyW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 11:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBMQyR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 11:54:17 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4548B2054A;
        Mon, 13 Feb 2023 08:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCd/m6WbrkEt4BzIOFFFUaZiH8weiDcdgUtMVBbF/VpcWZFLZRGLnB9G+KIrNAjp402WqLSj8h9zeKtHTC+DVsNIeOade41PU/JLmwfo9qtuZZybb69iBJnYAh2E2Rh4/6kQgpe0jeVpwnFfJA06eJpz92Flzp7txBqsAwMzZSkbeMu36eZ1fBMQjue3ro1W8u6sEkW5Uko9sOfO2d8oeLzyJAjk2jMlKKNBt3D2ut+xRnaA43vikfPWK3fOSa7dElYh19UYwbvBYosrFU2lmyE7pGyTn8Pow4BIYTzdBXJCgfJvrUBFmGM+AK1P+q8OTTsWHmlnthqbnWV0SjXH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npPOskjzIPxjepQohGCksLT5NfRk6QyoWAIykQ4pt5M=;
 b=c8sEEbh+GIYJaMsas8GwLnBGkzE2QL39afcp1RCuIbzTO6HJF3ddBD0lLoksK5pOYcJ78P89F3H0vTvTEQnC3uDYrySn5CNO8Apm5D4xwIFJ8T5rWg8IvT+/88DbjegCc745PPaMnb8H+i4MAaNpJVvhaBvdQiqbvieWFqDxxj3nKz3oBBq5URpvTmTSy1fQWbVCDNgUsCHIZ15iy/fRzXdGfZAOFyVKIHm+nYw149HFtO7FduLW7DKGPOHXAId7Mz5Ya6Eq/i+ASEuokT71gaX60wELA8f5bUi2lzE/KiKildfiGzMP96SadDzMu/UP8bDQ7m2VcFfSycxwQ8Tzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npPOskjzIPxjepQohGCksLT5NfRk6QyoWAIykQ4pt5M=;
 b=I6Y48l6Dut0386mk0njXuMcbvICnVptGqqtzpHgtRO/h4u1fJtq11dyr9w/BndVnFbqIeD7MBDnHHrQMexrn545jBL4rrGDL052D7dANVjIfPgCEBmktxtWOQoK3vqzFnSeiQBOIZAfq9foDIocwyGXvnGQbxh/KxTsfnYzqAv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 16:54:00 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff%7]) with mapi id 15.20.6086.019; Mon, 13 Feb 2023
 16:53:59 +0000
Date:   Mon, 13 Feb 2023 16:53:51 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 06/22] EDAC/amd64: Rename debug_display_dimm_sizes()
Message-ID: <Y+prH/8fBC2nYHeE@yaz-fattaah>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
 <20230127170419.1824692-7-yazen.ghannam@amd.com>
 <Y+UCT9GizQYGRGYb@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+UCT9GizQYGRGYb@zn.tnic>
X-ClientProxiedBy: CH0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:610:cd::28) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BL1PR12MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd54171-c57b-43e2-ffe7-08db0de2e736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJdLgyBiHNifmklCM0TRSDUFdlMUcTutjwiBvLJlcLK9NS+VObHrLTCZ0e+TPo5+2Zo/XCD+k1bxsFwGiI/VaR1wtGHQ+WNBGsNxRg7swOR8X/TXGRcg3/KDIw9BPJczqXFw1s/IVuUQBRt8sonneVjs30piPmqIphOHSDgj3s4fo9YsvM9+JsxRT3QDmv1LsrCtyoiVqyV4FjS8dBuQDm2VZQMZ2sIaFro4fGqIfKoCyYy952J75HOLTHekT2CmFm23/Kh5MnQLo/ChljaUKjQjNoC6ZBrL7iE+BEeQEuFeq8YmPed4q9hw1kIh4mkin/4n20dtcu0rsNV9HEkeuJHi7nWgmITbKhThmoDmXq592blKZpUO5W2s9hrF9xiNCwORUnENeoGjUKhgUvQVznPB/MGdKtmzP8qrUqttpw7KAFlrcAiuAGZIAQulLEzvWwd/zbhC7uRAYqxvRlI7tZjJAMANUneILcdAVCN4jZtHCAnyRP8QiEm+bfCGKRff/n4L1o8MZ/2bUBsirIQR7vj6jDEkMQg9NcGZ6PMStCpIjXtW5dLPB8xzZGdUl35XYsMgxSgy50PihJ1ne6a1D1uaTXkHI36//is7zE719i9lC/MukixxFpBMSwoL9rTUahUgp0Z3c3DX4A+p8ZmTHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199018)(44832011)(4744005)(2906002)(5660300002)(83380400001)(186003)(26005)(9686003)(33716001)(38100700002)(66946007)(6916009)(8676002)(4326008)(316002)(66476007)(66556008)(8936002)(41300700001)(6666004)(478600001)(6512007)(6506007)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcVCZnm5pvanzgSU8BDuNNu2Aqip/JEsA9Mv+yyfhEbvDBbLeHcU38UtVpa3?=
 =?us-ascii?Q?jqr+u0DWbX9VWYKWhlgR4R/yZAVJdLJvFLmCqHh1q7Jq5HWIuQsfhcb/ZJtg?=
 =?us-ascii?Q?327WNjTx/VjRx3WWYEOBe4u2yDnzk5gsI6PbE+Wiks8P6AiZQPuhRv+ACdYs?=
 =?us-ascii?Q?tcidPZLeC0zUtxjstdJMT0RFuy08Lvk/s3r7j3vpqabzClNkJkUmr4xQHVNl?=
 =?us-ascii?Q?F38wke8PiSLZgynqtTEgPyv36B29b1RRe49ewHHoO3PmCQ8Lb60n4baLsR95?=
 =?us-ascii?Q?0wx96EDGy+kV1dR+eLy+qfZSSBBzzIJ4k7wod7F7v2vJKZhvIyx4eAI5ji57?=
 =?us-ascii?Q?MPPKnPcYFsfm1uIH1TGcdvGQKsbec5nww+sL7JZTyHtSc+hK3ssXBkM3QK6X?=
 =?us-ascii?Q?cAKNyyaPn7savFXGOEoH4IU9YRGrWKUGZy1GgBBMpoC12Ydv2n+NJZwXmXi8?=
 =?us-ascii?Q?NqShSEOasUW5/SbZGz/uPL9nXjv87bPcSm1wdw7lZWoPsd5TlHq4yKR55/Wq?=
 =?us-ascii?Q?vGypn9zAeO3xX2KnYlIn2BOKqtD/nZllx0Xq4qEV5d/4jUBwKLY7219YZ4q6?=
 =?us-ascii?Q?6xoYXLs/6wCRI+0vRZJ74T+e8V0gk2rp6OOmNOgXzyu058DytJPodYad5A4l?=
 =?us-ascii?Q?4AXXL6SwZC6dqQ4N69ssERCr/EZa32dakpb50PDO3yvRk97Q+lF31w+s5JLB?=
 =?us-ascii?Q?5wjwKyxskOhlK/CmIf4EOqICa/BqwBdo1v4Bflq59fcx7/lvm3TfLkucJExO?=
 =?us-ascii?Q?0/dzbIJfMzj3obIeyWHkNNo1W5uobmEXCpXHnC9lB+rh2k1niPw6fEDhY/dZ?=
 =?us-ascii?Q?mxaMAl51XQglKBWgzXN7G17CCChJIGhSenqPijslPPYLKaz72SSlZg7VPB3z?=
 =?us-ascii?Q?y1/LoXyeS1ABD5Oe9YTwwOptD9Su8MagYvYHjSl+4ZTkgx63lT83V44rcoe3?=
 =?us-ascii?Q?P/c8YkQKz40B4zYsLgs8cniQecz6wglbDqlFZHoND9yHM61iVTgrxs5rPZby?=
 =?us-ascii?Q?+s3Q7gr4FKF+K/u4+EzTeXX6/qEXx99RWPDFXyHBO3T90JMuXax6+4H8/Kuy?=
 =?us-ascii?Q?UlKBXoPQsJ63iTExxq5GeyGC739QlxyHOmWXM5OwDkBabrRlDrlZn28wUMdB?=
 =?us-ascii?Q?27Ew+0AxLcMZTiJuuH56P2mazSqdDGUBF7ybdUz1FrDNIpdSbE/dg86fRh/s?=
 =?us-ascii?Q?jaZLtsR4XpM28dHhTRIZT3JQwYAbN06SGP59ub/WXZhueths63mG+6mn89xj?=
 =?us-ascii?Q?t8ANR/IEP/0YCRaUpMIU4sGTET5Pb16YO5vKDkuuG7EzUPONaZdopEqMeQTn?=
 =?us-ascii?Q?bBYXMrmnBAdYutNsInoW2jpmdd5dRcKgE9bLWO1jrjq83xMYiBj9cyEwtAHE?=
 =?us-ascii?Q?AHgBKfC5VPIDHAOKbJWIU5wYN75hfh7F7bDQJUsVYGJbHksLhMtn8lZjBrDd?=
 =?us-ascii?Q?DznVJDTanbDiEQj8B3hGuGS8IJS1qYfy0TlyCpOo8ua6mEv1ml+TZ9dxdTRL?=
 =?us-ascii?Q?dWor5oKx1Gb5efT48O2QaWuRHwztfkYbKyIMgq09ke/ckSWkn3krZSvDlxsH?=
 =?us-ascii?Q?WdTFwhxYIXx2PkhF4UO+fqeNmWmZ0bXkiFFV1vEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd54171-c57b-43e2-ffe7-08db0de2e736
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:53:59.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLnjZ+EvOcb2YKCZGIpDEvL8d9BMHhWw/OyoLzECeY96Jr3xtmjbN9mNgyo4g5Vj/w2YF4Dsn4OzdR0hlbVrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 09, 2023 at 03:25:19PM +0100, Borislav Petkov wrote:
> On Fri, Jan 27, 2023 at 05:04:03PM +0000, Yazen Ghannam wrote:
> > Use the "dct" and "umc" prefixes for legacy and modern versions
> > respectively.
> > 
> > Also, move the "dct" version to avoid a forward declaration, and fixup
> > some checkpatch warnings in the process.
> 
> Yeah, but it is hard to review a move and changes in a single patch.
> Pls split it into
> 
> 1. Mechanical move only
> 2. Other changes
>

Understood. Patch 8 also has a move, so I'll split that one too.

Would you like me to resend the entire set? Do you have comments on the
remaining patches?

Thanks,
Yazen
