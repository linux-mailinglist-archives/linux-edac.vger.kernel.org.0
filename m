Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456334E9C32
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiC1Q2J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 12:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242217AbiC1Q2B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 12:28:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A7B5F260
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 09:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeW4EVclSDDf3qftOMB8AHRtM7ebMcJNirBEYccrNnJB5kJfLt/wHIz5ux5mKZ1aaupTR653/xv4OfBesZvyNgK16OewO24/r2ltTmsI0N1VRigiMHCORI9I8Pw0nCarcsUZeJ1VINm/d95VOZ55tGKwWw9AfeQOvF4iEbhi2s+BFgTZaZNstfUwYuENMNf0vptYSckviyUc5CjOrN4zfKC2K2N5jkuAqM4t9CTEX/CGb5jRRf5Ky9/OT5q3Tr7mUr6Jp7OAoxMP4RFNg9FHk2eqWQcCtEI1Dvwr9JgbFZj3zVy55qmyodgeu7JeP72+zz8E7aa89QbUdrlCuqvsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5kDGh4E+qMW7PjAiJ7L/65lae/rH7cq/5T9eGevLTc=;
 b=gkyqSeBv5VBl0c4nTp1HyVXjZVAAN4xyzKn4/Ek46XdcidN/Ar7hgE1ZXTdunbUBchDLpFBPgzOusS4Onsb0LW+0HnG6R87XSRgafI3OePLg1cgx4w59Wpa383j9XNZuZCD4j9BKSCIhDp3ME0llcCS2VkF2fONIxOSGDbckoPrE5M9hn5fXZv/ZStZCb3Keo+SxU+y/RhsmjK1v/jqlDxtajIsyQX5QrntQU3Su6dZnBSZdn0OpyA9FqRi/m6VHXPnTSkG3f3jhupArzA5/EqREVHO8CK+pCM8LMY8L27yY/wn4+xy7B+0/KQRni8hKCDoW/5uQ50Z+bchc8foNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5kDGh4E+qMW7PjAiJ7L/65lae/rH7cq/5T9eGevLTc=;
 b=4hNEtpm5HNoToXiKeqj/bjcGaTSG8sVRGwfQYQCL93kshRabYFTuG6fuaC77CekC/w+ahdXgSIOFs8XsBokZtzgo2nrIMqqLfL5zaUCW9kD1ACzocR1ofsJsbzdL9c4n0lId5KjfxFCSmpwLC4Yu/IroKbYjolpXVBel5bbsers=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 16:26:17 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:26:17 +0000
Date:   Mon, 28 Mar 2022 16:26:14 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 09/14] EDAC/amd64: Add determine_edac_ctl_cap() into
 pvt->ops
Message-ID: <YkHhphvZ8RSgeoav@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-10-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-10-nchatrad@amd.com>
X-ClientProxiedBy: BL1PR13CA0291.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3da68b5-344e-4751-b85e-08da10d7af55
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754F0ED6D6B8CBB03F87FCBF81D9@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBLOMyGILtQYxRzhTlbtAtt++yiDHrX/ihvMiLJLCgD04PKPHEDjbk8aBiTcE/ZI9OYQyLG+hz/1GypT29vxsKjtwYugrzdyrywFgJoBzTYX5VP7fuOaJnz2DamxkGJU8q1OWlkulNyKuvjmn0CROXN5Bq4sox6x1IjTvFy6S6CoP+YxghK2Qvpj9OyFJfzx2lkWQZCYAS502lBhWzAxiOlh3+kOCaPfBapzfEOn67Xmo8jk/qVWO0DRCDfZ8nmq/QzCC+QVbQabJDo+1xmxM9yXuLloCzfp2bLK5TtIiPGL4tK9SAEdtzqjH0VDgP4kHq1upHmK6nZP5Gg3MtsjvV6r/yVJUlzRcF1tdNp0YRn3eQ5BBivzTm7WZvgrQQR/xr7nY+w7FYhepDQADoFQXCnkS1NOpFqrXjdJ9AXPd2e2ZT8jltw7ID0I5rHdxFh+pKGFofCRBc1QuAzXVvI4fmXiZnp6c/ihS1c+tlnwkiYl3IdDIJnce8SyzOCFkrMgRpYJ9eo3xi8rwQsvBv4x3H/BISPm75ItynK6zHqdWmIH0QMqV0hMZ8B/oe2KGWkD8Y7Xm0cZvaGox40x4f41ugLPSjVrwWWflcdXA1G9nIJXpaNUjWiTd3dH+CGaVus6reuIGu9scSX9w30zx/M3ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(508600001)(83380400001)(6636002)(6506007)(6486002)(38100700002)(44832011)(4744005)(6666004)(2906002)(8936002)(5660300002)(86362001)(8676002)(6862004)(4326008)(6512007)(9686003)(66476007)(66946007)(66556008)(26005)(186003)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPFuJKKaxRd16iY/ekSoDm1/XB+0m7MJ64MsGGxNx5lrcu42/04H43DDxL+C?=
 =?us-ascii?Q?LhjZgTshbZcFhZ1x1goIyqc7Ias29Q/noGhxlLpgbkVDsk8Zm9riAaEi3Xue?=
 =?us-ascii?Q?Q13MaDjgF1gCmNNyYqXc82+zkcKAQPdxGyl02OUnElUNK436O0JIJc4JymM+?=
 =?us-ascii?Q?rQ6Hh0StjeVmzHdMerp5E7OIa4TR3wJuD2VrGUooLh+CwVp+H6DACJhzw3sM?=
 =?us-ascii?Q?3rvwtFw01raIwoEKZYyhtAHRmIqJOytdcxwuDJ8RXFUgCeEwPGhKl1l2tera?=
 =?us-ascii?Q?mQc832RFHVXhRQe3caLw2QvXvAxWfz538+Zj5ECW+xdxvAvnkaL0FJ6oaxQV?=
 =?us-ascii?Q?+UjlIc/y9rAr5RfznND+ziCfgyzuhDrjWLl0Sz0MZABPnPJIfxpExmW74MO8?=
 =?us-ascii?Q?4EIgBGCnYakz9sUgTBkJUgzPQmN2CKWyGappEqFfD8dhQUUaRX3CHQrqVZSp?=
 =?us-ascii?Q?vD3stWb+2tyyiuwta4MIX9oESkOAf0vYFngO2c+QxaHbBpi+QPjl7wBb8+QI?=
 =?us-ascii?Q?iJLE0L6splnmWJ5G5/IqqqKXAuiAMDerk9aV0j9EXZaVfgLA7NymHcKGe4JG?=
 =?us-ascii?Q?xNw8vFdd/yRDdQUU4hIizgYsp0gaPKV+sSxuCnG3m9n5T9WYnO375z/JA3SL?=
 =?us-ascii?Q?B5mO4bYDSgCRgIy4ncesXfkEcsmi7wzsK1Aeo1lnNwGlSjHOClGanUwc3ZCq?=
 =?us-ascii?Q?VldmFuqikc63OxexxR0A1qeblD66ln3tUP5ZUIlNH5rwHYb/kFp/hXSDeDnA?=
 =?us-ascii?Q?DE+J+r+A21fCKDIcvsEmy4sPiXktKm+slY1V3heGHHUqEQ3SUgPI5qhbPM8K?=
 =?us-ascii?Q?XQzEIrzcvLTxzx1HUqWhetnMWPQwaJY2P8+1mjKmNxCnOHv/06WqI+Sqq0gs?=
 =?us-ascii?Q?rMb82k4MO+J2f9b1WD+jjkDFmyz15irKjwj90KJNEiyBqRbFV9EbL8mmsyGL?=
 =?us-ascii?Q?eaFzr+n0II9YcDdRGS4v2bhsQfsiBZA8e1tES8UlHsUgVydztPtUShpvgeRi?=
 =?us-ascii?Q?KdmSPJwhkVL7GKGnuf+tOKarY9Fx9/9YYx6xDcZOdqofKCk/y9ChHFkpMar/?=
 =?us-ascii?Q?EnPsv46jgAII7EKerrmD2VBI0lq0F/amP9UoUQNgbyMZobW6MOhPAQe+7DiO?=
 =?us-ascii?Q?t6GYpBHlnKWiPAi0EvNmkXS28BqtBYD38hZY/p3SUhf/4S/5TFNd0wO3x/LP?=
 =?us-ascii?Q?S4J492Yhl4ljiEqm/r0joqmVwrPyXuONU/BYQXTuIwxtu/v1Tps0EZ3jogWm?=
 =?us-ascii?Q?iy7n3h6K4mq1n623i0yVaTsBs9VOhjyLDfnLBvCPn2a3fkC1e17W8bkW40i2?=
 =?us-ascii?Q?Ec4gkkiZgHsRm8/uQeCxhKuWyEj6Es+Tvei2OE/sxwaxdZ7ZNqJp0YNIKyF8?=
 =?us-ascii?Q?2pJXUF1fs4Mvds9UTQVCT7urWHGh3BnRG7Xc8nrnO0aiwGNPVaXOB+2loSjD?=
 =?us-ascii?Q?TWi7TXTL5qakP5NvpKLL22UCNqdBza9WBVBvjZaF/M464fC9BmWVE2OK7DVM?=
 =?us-ascii?Q?oAlfBzrfJ38Cv617qAUVNdbFMoWkqVfx5j2MXmGor9qgyaWUBrhgZTM0mCXj?=
 =?us-ascii?Q?mQMqeJa6Wd0Hw8EbHCxP+J6l10fLOiy2Fq8gIZXNNMGQMOlmmwF6ELWOgvML?=
 =?us-ascii?Q?VoiP/h5VhcQbKILwWCWgD4qys6kaZGbOgj1WHw9e8K/QxzH8xQ7PgRZfeJGw?=
 =?us-ascii?Q?gb5GU/TbgZ6DQS0wr9a43730veatts2oAKHrmag6QSKF9uGNy404KI3bfR3c?=
 =?us-ascii?Q?aaf/ARU72g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3da68b5-344e-4751-b85e-08da10d7af55
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:26:17.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpE1Dtr1/Vx1ZSv4I7IGogIJDO+vBBHAqxnqGu+5KHjNoeFRUvTuRkeYAOBmDuMlUgx+0oH/XILuajjPX+b2qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:49PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for determine_edac_ctl_cap() in pvt->ops and assign
> family specific determine_edac_ctl_cap() definitions appropriately.
>

Please include the "why".

And like the previous patch, this looks okay overall but we should verify the
EDAC_FLAGs.

Thanks,
Yazen 
