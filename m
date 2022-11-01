Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802156150D2
	for <lists+linux-edac@lfdr.de>; Tue,  1 Nov 2022 18:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKARgR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Nov 2022 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKARgP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Nov 2022 13:36:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423F6354;
        Tue,  1 Nov 2022 10:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc9WBB9JJh8kXt4e1BzgZw6Xu+bhl17RJTHabxLX2r7kEda0OIGgWP6kI4rTlDJEFYtBsy78yxDsn7KkDzF4fgNvQvq2NJeZJm3e9pCHPSz90SqOUkAFIYslJsne0jj+KluwdK0IeOUE94de4p8TRW65aTmDDvMcqeX6M7SIDqrvH2a8R5fXVXlwiaYTxkxqVQVI3y1gzgigLBp/8kosEdmc2fjQT4Heo6+u1jsE5XzX1y9A7BZHlWbaoNuGdE0yoFsrDjv/WDYc/TtjyVP7Dhqm30YgWfRUu1BfMWwlc10OgsNPdRnbFKneKMkMbAnLdie0nLa0UPcvixKGoKubFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+/VARBaWRheOvs6fufNswFzSKw4QkTS8k52R4JRobI=;
 b=g15fSSpg/rik+/OIXuYeDR2lyc2IRiw3RWOs9B5PsKkb4uYRnGz79ViVnAWOxqzt7RRt+XEAlqWsc3Syzdcb62p92zSqlPPcJMu1xJHSu+jgM/IjS+0xTRz1OebskMyJwAmzahFj93O9B9yOaDPR+oLSXODEV/EvRsRtISrRQABac6nhN61qFVILvpFew6Lgj23N/0VSzLUhJXDxKFmR+UC1f5YDO8g0aPw0V97YS8crOOlNlsC60dJzhMFrJX0kMPdoWleJICE1DAOj9qsdOq9jHn3j+qEhCZKXAxjAL/N5d+6loJu0IAgKMB++tUVB1RYHts/YRRNvc0C8zcHfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+/VARBaWRheOvs6fufNswFzSKw4QkTS8k52R4JRobI=;
 b=Z80relIWgBwB0H0MVv9jqbgTboR9LIQiUeJRLA3iJOk1lCoZXcDGKgTRlZH9AojGwaf3Fy6FW6iCmdv5n2VlzBZlCN14JXhWS6JELLyp0f7+0w90MRJPWGlhDhOhvYUyYWpKirlbXoPWi8TpJfiGNbDKaE3H0W+Qu+4ahEGHfds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 17:36:09 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:36:09 +0000
Date:   Tue, 1 Nov 2022 17:36:05 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Dump stack after certain machine checks
Message-ID: <Y2FZBfCFMSmXduxv@yaz-fattaah>
References: <20220922195136.54575-1-tony.luck@intel.com>
 <Y1+jqyh8dAz6tsTr@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1+jqyh8dAz6tsTr@zn.tnic>
X-ClientProxiedBy: CH0PR03CA0448.namprd03.prod.outlook.com
 (2603:10b6:610:10e::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: f9be2f90-8694-45a7-9596-08dabc2f8fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKF8i7ZUD3jTICkERPqS4GOdtwKlocugSr323f47bsm6itQC3aTLfcDIGJmoT/pdLWS9ty5fG04YBgkva1oh2S2J5k0x9++9stPU7LSNuQnNewlAc811uyTSQl0t7K2X4yx0NkvgA+yWW5C7jEfSpua6U0FqH59ua98h+KlOy0c0XOldhfY80m3ZF/ZcEhuzqIbC7D7yJ4xFrhh2oYzeiU8RvM3hlYQs5GGkHL2bSKstRD+8eay8Jagk9vzZ2XjD1RUz0HDAB2B8KRTDg6Kaie2gOm5j9KnMLJpBZWIT6rvi7h9DBftZLEmCWAccT2f4tY4/0xLigx++e1PbL72evVS7CjwuQ9we3soQCKPZ7+6QcvCcNJFIZjR83Qkr6fEmOeYQB3fDljhL6txPgwCdyR5oaaZVErSLDsUKRhiTxYVLrrr1Ddxg7V8oUtHBqXHo4+lTQnmOCkg9lYJXn25t4f4crA6+oQBeRCdcqA4E3TTKeYGAc0rRcE8LKfly5er3gA0hQ7MVPhY1NcGjlSAu2Kr7f4PUx3d17QC4PD0pOGaKeE6FjPFZ5dh5t4XS8QyxXrRuD7/a/z+dTWb6RYLLWejERmqfdb1j4ecnooyPPVLQLWzBqkqffiav5HgZ893HkVNHqSUSxExhwDOmxXPUqZbNF/3McWx22O3fJSzKg68UrNn4qUV+vJIB3YDlvjOsCOBzYdH2B47fugXSq3zQRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(41300700001)(5660300002)(66556008)(2906002)(44832011)(54906003)(8676002)(316002)(6916009)(66946007)(66476007)(4326008)(4744005)(6486002)(83380400001)(8936002)(6506007)(6666004)(86362001)(186003)(26005)(9686003)(38100700002)(478600001)(6512007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KP0Ge2VjriOI/NNMMVDDfw0GoQ55aoc3PkwJVCeeZnKWQVrh70Q6ib2kJMPt?=
 =?us-ascii?Q?JDzXm4biT0i9z99Wzo6X4Eo/STTpvFnra9N5ghoFKNaegys1/iJSIqnU4e4G?=
 =?us-ascii?Q?ilMsFmDaIf51CwxW0dkAHrP3yhZBdbWI4thEkwn7eTur2vo66T4Bwj6VUnAq?=
 =?us-ascii?Q?fFkMZh37jVmLXNZbi0Q2sxMu8sdvYba65n0YCgxcJs5uWwh8vCo9vyHk+Ubt?=
 =?us-ascii?Q?TC77z+rCYDo/PAOdNSHk7fem0LFYzjEAAdL7wT5EuGv+Ta2UICohoRbDwYQA?=
 =?us-ascii?Q?mKmHPK8q+NjE+t5yFLgWE5GOqZvGoo9lxYAPri0OzZDxPZBuSUJShvyMocc9?=
 =?us-ascii?Q?LANIwkDe2Mk5aPWF19ODv3kEyCKBRvd7VVT0f7BpDywqM3+oIU0Q26nNPLg3?=
 =?us-ascii?Q?q/FkxDGqs3PPtXpKVDFceTwJxHeH5fz1wXs3RQ5tthaLDwal++tlSlMef0+2?=
 =?us-ascii?Q?d5N6KLtE4zfXtevDKVfAU11I2FK+moJon+OXxq6mhZpTP2m73rjm22ZES4oP?=
 =?us-ascii?Q?2kxuNWUhPI827IwJjy3v8ZcAIdbQskeV8WOYRoTZKkniC5d5xYRcuB/O4Eoe?=
 =?us-ascii?Q?ZmfKS6H9P+QA4hdS5dW82s0r2WL3P3CfyDxiLh5k6TUYidF4jTnnBXIv7igi?=
 =?us-ascii?Q?HRnc1HMi0RPqy4Z22FWAlWj3lCXV93dT5skKsJyMDiyG1HitJ36mIelEwkRj?=
 =?us-ascii?Q?uuYTERDsYdPGuQC3mUuNka2anzmkcv350AR7CDPtNQ5YAhbGZLmUUDzwWMVO?=
 =?us-ascii?Q?gG34gKI78NJ7W42eOQaQDScc6u4iD/5HBgO2Ed+ZLZ/y0SkiZ5fAXXdjtGhT?=
 =?us-ascii?Q?QfT/dnXsOoXRwUPfJoyCzK6aYn9IId2BqBrycTFnNeI8yqLK6ivyUmnLrTwy?=
 =?us-ascii?Q?vUzQr7BOFdQDhY6+BCfqFvuKjHgf1ahZHadeEOUinBFdpi1k/VkHM2a+HqOA?=
 =?us-ascii?Q?gxHkF4DM54W2PraLz6EiAmR8j4AOcFv5q8zTAEB+b9rFmxMS+dNoQJHCwtGc?=
 =?us-ascii?Q?h/LQOZLQuBTCEhZrZUEKU1x6IU0gyhB02TvGL9AJAnNPgfkdaouw9nTry72+?=
 =?us-ascii?Q?D6MQqkhg6dnziDW6VTp260+DpRqNDGEEsK+q5G0pW0xbOrj2KX0irz5UwlYU?=
 =?us-ascii?Q?4KL1pG/4Cx9APOxUUbCS3z77fGu+HOjBgeytTRKGH9/1mlMXRUWwR7W204zb?=
 =?us-ascii?Q?r8amB7YujdVk03yGWZ0EqeqEkd8IdyyEL9iYFEU1FBYGUosuAUnN7fzXWyAD?=
 =?us-ascii?Q?u8CJPI0QMC4q/2K36X0DnFpmP9m3uQU8Vgt6cHXzuD3TdMjq+HDMOhd6ROI1?=
 =?us-ascii?Q?yIIMhatsgEtVOHl1z4ZXxXuevpdbKPJeXnGpGixwfwGgH4xGr/7kdhhN2i6R?=
 =?us-ascii?Q?C1Uh6TQvsRcm1vJVwIwkYQ2QKMJiZzD3FdtkIQ+bLpzS1nclkNOgyHcDT3Xk?=
 =?us-ascii?Q?PedptS7N8UwKV6lAqbyWctfZ/HAc9bF2BD7AjURFbcHb98apvOlu2A/5572b?=
 =?us-ascii?Q?3b1K7mCgCuk0cma6yvvZw9NbL5rbJrzEg6IVwv7UHrNEwKEGaW5CmdRWXnP5?=
 =?us-ascii?Q?75kz6W8Gy8jRTowGm29ANxRqDgzGldanSbhYxk/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9be2f90-8694-45a7-9596-08dabc2f8fcd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 17:36:09.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flKK2qOD94OVGzgifBXaVPkYFjrI3DLIVlZbDnSirzk0EU6+vQKon1NiclC9SHNYp/KD9Az4g12WTDOX7ssOjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 31, 2022 at 11:30:03AM +0100, Borislav Petkov wrote:
> On Thu, Sep 22, 2022 at 12:51:34PM -0700, Tony Luck wrote:
> > I've only updated the Intel severity calculation to use this new
> > severity level. I'm not sure if AMD also has situations where this would
> > be useful. If so, then mce_severity_amd() would need to be updated too
> > to return different severity for IN_KERNEL and IN_KERNEL_RECOV cases.
> 
> I'd look into Yazen's direction for that...
>

Yes, I think this is something we can look into. I'm not aware of any
situations at the moment. But I'd like to start focusing more on the various
recovery paths and corner cases.

Thanks,
Yazen
