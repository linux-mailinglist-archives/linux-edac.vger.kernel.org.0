Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846436A769E
	for <lists+linux-edac@lfdr.de>; Wed,  1 Mar 2023 23:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCAWIh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Mar 2023 17:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAWIg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Mar 2023 17:08:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1C497FC;
        Wed,  1 Mar 2023 14:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRSt8gObeOol1eX1bBx0ok0s2fC5I6WNRf8wetnjwsdx/WwoFCZ5Ma9iTP6MDKuKRqdJL+K4+mGbRtb3LsoXl24gdDB4kfwHmQU+FJeBlw4gTKlC2WsF7SRQjqLykJ2UvdwskRYpXRVHWtPHz/fvUtUvkDEExhXiabZqq+pMqVrQ1wqW2igpxyIIaABvkgcvvTqb9yTw5RZkoVpCj/vnVY84VMa7k0q41NlfDIBPxj+VR2BeUa+q8lz2Nvee/a41dcgtCAGQXBmGrTdgQPNW8n2qtTxGh/t9nREDR5zeHf2RfBAIKmRDvvNgrX2D9WZVWC5ck+jTGIXtPPSxNANIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TX/sYRRTwI7HaMXt7FmKMVfXKf9LxyEzDeCjTNmHYo=;
 b=mwHBV7U1P9dyy2KfmCNHr2OA+pD3eS8V2FtbNfPvotdiwo/aJG2KTBR3TOyTvvoC7m62N3glBFvbfIKqL4/MVGrRMk6gvGfWa6jXwGAeqIKbdYZxcK0IgT/gxOHRkX9cJXP+ya/sKNFa4pFjxWCQht6H0GQKEjIduT1Ko8rNNIGnbhxjqREyXeigbIFf46S5WZqOPWv+IrUemi543iKrZineVNT1/pMFDNp+XJhO3P3vD9rCNbRSeRdISsEKv1AlUHg1xyia69u3/f4GoGD/Qs6iI3KD+9WF8Xk8Sk8ESl+8SuwiU8nD+ELav+pLg2J4DQLcL/KwBJH99+4Xeoq2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TX/sYRRTwI7HaMXt7FmKMVfXKf9LxyEzDeCjTNmHYo=;
 b=F12qcXjmfEeYqMoHYgOsAX9oqwvDTGv0aZaTgt0Kh6UWJKGY2QUWwstanbyymzFFW/+fTNKmHEm1Y9LjNTIAI3NTUa+4ZNyRwLWCjXggBCmeHOsCA+PFn/EF4rqNUx/r1d9lHY3vlVvSIYV53Cwswk5O51VUi0SFU1CPIIl2yEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 22:08:33 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 22:08:32 +0000
Date:   Wed, 1 Mar 2023 17:08:28 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mce: Schedule work after restart from sysfs update
Message-ID: <Y//M3M3X0ra0IF99@yaz-mtwr>
References: <20230301202623.2092271-1-yazen.ghannam@amd.com>
 <SJ1PR11MB60836DFF088E54BB770D1638FCAD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60836DFF088E54BB770D1638FCAD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:610:60::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4a0da8-5cbd-4a60-80c0-08db1aa17f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzM2mnodj9lL9P2MzlBQbx/zEV7xTEU+CNrYzdWtvfoFHukUYNhn58wmI7ykala1DTdl7g1h4tNbcvfyG56I4veac+FHhaYsubTo2dwepDWW1We5CKf61eWmMd0kXNEHNOcgTSOk0aSRNyTAmJaJhntIePGTHDj0rOrD90+87gvbf0cgIffLGZ8NBnFueeHqKKIm3c4SP04y2aSPV9wtjdgaywGrOJTgVVr2y+L+dCBlKKw/WscMlpXyOoOsPnQUfNeGMyurS37+nNIyTermqV0/Z6372AKmdeW5rbbnuirNoO1c6oxT+Rfyf4OMIbAHOiv1YQhGZtYGWG5lf5uS7zWDODFJE5rjXbKMSFZk50P2075kDkSy7BHzf9kFp+ytoH2cAVJPwTzt+WJNKxrvomByJkGKD1mKknxjmTbWujRVNVsnBh5TkUCVt7M+cZyEhypVQfDY1+emDeElThsS5HV2usKjyech9wBZdEqDFIn0n7vsoG0O3m4P1bhYQUhbT8qE3PMZKUCKR1C1wDtCEKi60c/iztPlgJC4+HjGMQDUXnndiOsSJaAlHtakfmKb/r8aQ+Kjo9tjXZQYvPwUPWHWhBIDLvAQ5Zk7NasSIpzmQjyxS14XSJBjfG7nchH2fQpgAOBpFSxKngT8jelxAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199018)(4326008)(38100700002)(41300700001)(8936002)(86362001)(44832011)(66556008)(558084003)(66476007)(2906002)(15650500001)(6916009)(66946007)(5660300002)(8676002)(33716001)(6506007)(26005)(186003)(83380400001)(9686003)(6512007)(316002)(54906003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnopGb/w7R0ssv7doKqf07LiU5E6QdfScF5v3Gju9nMiHp5IiZMmII5Hc4wY?=
 =?us-ascii?Q?l0QgwXcVJHuDSDqxOEMbSR4q89KCLXwdG30GqOR6WzCr+BAuYYuibG3oo82W?=
 =?us-ascii?Q?Js3DmpTlxkVpweuOZSmOym2kvASIrFxTsDMhJ2D7H20qXpRN5h3uYs0u6maV?=
 =?us-ascii?Q?ywqBATYvLaUYL0AQefHzwYgJQslEH7KPkhmd4ZTzzGQS3F+3uG2545XV59Sp?=
 =?us-ascii?Q?3RfeLppcyu149PCUjLckAxaQUCdI4xXQca3jkYrQhElB6OhxBdHu2x7tVmz3?=
 =?us-ascii?Q?zOxafXymDRN4+h7SM0GABnPamrODoH3Odo/l9EozBuAXNmfOUdrp58PGPv8S?=
 =?us-ascii?Q?5XmykzLkRZmtfpOTdshn6/o+jCb+fR/8tO6crsd9R3nLRHmnJCI9HDEyNPp0?=
 =?us-ascii?Q?rCkjFdYk/WS4KJodRpKt6M26bD3NcH8Pywco+WhKvL9TTp6fcGprmr534tCE?=
 =?us-ascii?Q?STQ63hfg2FHendHIoTqKr5+gwT0v1Pp5DFR1oWcj5lN/g2fuX4ZDXoTi2NI6?=
 =?us-ascii?Q?kuXbvIY2uJlb7TMino4hi8JSUr83oySHy1qkJHeK1FPUM17YaO89yh4+Vucj?=
 =?us-ascii?Q?nZozFezQTPWemBfSx3aqd67WByVXCJ2BskXT+SJSf8KC4f48bRIizQIj4vyp?=
 =?us-ascii?Q?3E01t+puIWnp27kGKRwyWSrebWwFVvZ5a6EkMRt3nKv55iaIsuUFPVltpr40?=
 =?us-ascii?Q?4n2LM9dgcJ3TZq/YNWT2j6OsE+MtPZmUp72V0LZaP+C0zVwwZX2aVRkrJRoM?=
 =?us-ascii?Q?DLnY1R9nlXR7aDBrs/D+1t3Qd92pf4p2c+vEfxUf2rWIZOmQ9lkSkrO3Luf4?=
 =?us-ascii?Q?j3lclehyBGWfeaNHMWWJJ+z3QybMeOY+Eh2J7e2w847MxMbepXt0hFtYBzZc?=
 =?us-ascii?Q?jKiPX/KbHSYJwe+g0xVDhbyYD5CkhK5FqVeL9RXZjUnuWSRicPnPXKC9Vfg/?=
 =?us-ascii?Q?4Y6WFLBgcEexyT40hbync+EUPX1p5V57GDzpscSF0kMy1PzHiif4SviPlcn7?=
 =?us-ascii?Q?jbT0L+KADFMjJMiHaEUOaNMOd5HckXGQsmU2aGcHwaxWkz8QacvYxXYs08as?=
 =?us-ascii?Q?H05RHUnnHyRfR0JigiwpNimuvhHYRvm1OyWUA/8MTpo81yuv/M7a5azVrwXV?=
 =?us-ascii?Q?p7q3CVvN7TtstEfs964fRYpBNaXZGjlbzSPHkCUppZRiRn3C9Cmt7M2Az3PA?=
 =?us-ascii?Q?A2HZ46kWUce5/w9ffcA+yZ4cGVtu8IQBjR0A6whgFacoKSxcDUgalKKDu49x?=
 =?us-ascii?Q?qq36/9ef975x9GtCylW/lqOllIqpFAH9xzcIr5x4YMJJRvU9QvvJ39ecKQhP?=
 =?us-ascii?Q?wiLhJ4qSoHkA5LiA06lG4ZMXX02TehSYRZmoEvVDELA8pWx+kI1FmoKl2vY4?=
 =?us-ascii?Q?3TmonHfxNBPbMQb33Y9ggOTuB3mOsbWPu6XtmnAfijo9jGDZLcTq/6B/i8ph?=
 =?us-ascii?Q?LQrfkiQaewz2og6ZyP5YEfRjjbqHCMvPzTkDbN07X0Iy9wXcG9itX3LJzNWb?=
 =?us-ascii?Q?N8JqT/70BqmoT/qLlcxx1TZwjJ5jshfKuEniGWWDxz0WRcFns0aLrbVcDLVx?=
 =?us-ascii?Q?5B2xyIUWu6Tz5ZdeK7IFlRoCFGgOPp4XSA7a7eKT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4a0da8-5cbd-4a60-80c0-08db1aa17f10
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 22:08:32.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+UMSlgHSpSke+haOi3Kf3znAiwYx/PePfI278iKKu1EWFB1qjS7os/PI5ZP7/a8iE2Iqs61G9iNeSKq/OousQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 01, 2023 at 08:56:32PM +0000, Luck, Tony wrote:
> > A number of sysfs updates call mce_cpu_restart() which goes through a
> 
> I think that should say "call mce_restart()"
>

Yes, that's right. Thanks!

-Yazen
