Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3286152D654
	for <lists+linux-edac@lfdr.de>; Thu, 19 May 2022 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiESOnJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 May 2022 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiESOnD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 May 2022 10:43:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93368D02A4;
        Thu, 19 May 2022 07:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCt0Hakyd0B2VHcpi0FaWxzGp9Lk6ERIhiPA6TSxKgkeuHRvVkj7+Z75Z2it82+evUCPorIZ+rW8OAzaMe/bDYkuKMmHSr/r4zlbcDFCQDdBEwbZnmz90ELda9rRcY2SKS6NHH2kw5dfZgshwRz75MQJU4XeJ5xkHe8OBUKjFeTtFysGNtvd30KLuGzqsrxKxZZjz1HbdUhYKH4+IOcXyVOzMchZBRdkfQd+EasfASE0rxwbqA/m/1NuvzrxAOZLzq7D52nZ8H3xA8HLk47Os3p1x+9j4TSRZzsi1BHgrR+fVEY7pQyFREoSwCSxWfVQLjyrAQXSkaPYTewNdkb9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhwo5WGckuRL/7yilC7o8rVmjcO/wlcP+oDwJ0AKvPo=;
 b=Pal/CMwl360SG+R1XBI5V+30RNSrF1oBaSHZZlIfI1yjUC0r5kM98BnjJlee2ix2nmBZ6m+rVhsxeOEw53TYmFLY+n0wQD+cwTRQ2i1iYjEx1s0xLS7NXsKDdd3fSVwdkkyNQPLrgJbyZ0Lv4lOn41Cr0GZdwqXosKQbvy+uzDod0Zk4j/dOf1ye/DQOK5Emi/zWKiVM7xROGqr9oqkvfM3Zu1Nsc86uF8SY+itHryk6B+c2jpvrgOJtLyBglE0gZT8tIf/842z/oTSkoXAXRBOEL1cSX3wqSPGfu/xY7sjpZoy80kpLKe/3j4nWAzauxvmOuipOiFnlKLitNqVvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhwo5WGckuRL/7yilC7o8rVmjcO/wlcP+oDwJ0AKvPo=;
 b=oc1gaC0Kgl7O1OExteKKnabkz6L42DoAd7ADbQtBhIuLE9a3vX5gLM6Ls7/jvMcZMK6Fx9T8xTfWcVrQIC4OmvUkiHid3Yp6Oq24reKlJRXFR9EDJAJMvLut0CeKO/GGnqtdmZr24DzopyGBjGXbWRt3HX/bYSE6vTcDXb5SnEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 14:42:58 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928%2]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 14:42:58 +0000
Date:   Thu, 19 May 2022 14:42:55 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 06/18] EDAC/amd64: Add prep_chip_selects() into pvt->ops
Message-ID: <YoZXb44DCGDMYqtg@yaz-fattaah>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-7-yazen.ghannam@amd.com>
 <YoSp3cSoAo4SkkfQ@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoSp3cSoAo4SkkfQ@zn.tnic>
X-ClientProxiedBy: BL0PR02CA0091.namprd02.prod.outlook.com
 (2603:10b6:208:51::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa352aa-8fe3-4b62-39cd-08da39a5de2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43135206B3E7968CB9308B5AF8D09@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9hqoyrW5jnrPQksqhOR561nOor3R82TZ5GcclwReydzjOvbVbOsbisImYNjDzhGSnT2hNuiPw6TgjiDwRK33jrq+6/fagRBEfqk5tm0fk4hB+Wt0XoZ1fHqeOzG42+AcmmFl/xbU1hidcBOWFx3olTBWMVJJyQHNl2UUbX357Scv41YQK4WTZUhpFUjw7bGDLXQxgp5+1FhhLEXy1EPPHkyQlJQ+MbfPMdqs9//tlNk3qnW6PcFXTkN0JYqhIBdbD1BdvoqysKnuK2pWR7fQuWLIhnCGzIaGN9N5sUbcSd+U6X6QhdRnmiKjrXtLfO/TcDRuEpk7Cd55l7PfAUGbtfEb+6tR1Jd0f9nYqgTgMvyDOMS9lppZRK+z3QAU3apdLQ2uQAsnbBwh76QQNXgb3stt6j9+q7jgtgrpX+Fj9roX9FyOA7aa+yVJpHuJMBnu8JLt99iK2AJY3twp6XPwolIRPLSBBr6p2vH6dgIIA206SjK73ICeE5COj9rtJvE/OncSoLEb9PiQLvOei/dq/6/XD5guF6Ij4xfVKZXXK8yn48eOWHd+0jeg0F+S7qpofabWDZkWcaAHfiFDZdfIFDkQb1GV3PkA0HsC0KNSptGX314H/1+UHVCTrHcd1YR3kyVecr/syl3a7TEwUrH8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(2906002)(86362001)(33716001)(6506007)(316002)(6666004)(5660300002)(9686003)(66476007)(66946007)(6916009)(508600001)(6512007)(44832011)(6486002)(186003)(83380400001)(4326008)(8676002)(8936002)(26005)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DgWwytHSDQwxy2lg4PSOsvstuOifqmMyy+kpWes3CSoeGtKA8IaZC941WbG?=
 =?us-ascii?Q?g9KD8JVKIQZ1pMIsiYPj5XA4m6kZCKXSoPtuQZEjFCNj2FlvU9rsccESpRAW?=
 =?us-ascii?Q?Z5VGoggZce6b4LcQJfcWWlAQxk7bKEEFrOyM38QdFW/g0wW8/uc7/xBfOOTP?=
 =?us-ascii?Q?LXu+/Zic7cQ+05h0zm13vqGgear8XRCfSXhVSYZRmVtCViXO/IfTFZ5W3q5s?=
 =?us-ascii?Q?Hh4kXlf+WgLnT8KjOdZqxuBhNWlrD0Jtjd9LzCDcU7u0sDgWV9lQG73k0vXc?=
 =?us-ascii?Q?MLi4Qzt50CjVdPy2mfh6zArAUm+kxTRxp2Hh09BFDjKKg5mxC0kqVkZYF0qv?=
 =?us-ascii?Q?PkEymAw1J6cBI/K/zCAkMQn61ivLoY+wW+8kvCArR01jzuHbns7y1NsB46ok?=
 =?us-ascii?Q?S+iQvsDHd0SxemXGZwExzEkEj/WGCBurUBnsDeHuAJKWQjxoMe42KkQo6fUc?=
 =?us-ascii?Q?s8/WzeerXJh03GxG6W/PGJ61Y1OfCHsQS4PbGjlnf8ZUq9Md6fuSSTjQ3dJM?=
 =?us-ascii?Q?TGxf4GClXbm7+Drm8jm/yHDZ9wLIrEd1PxQf47WHxa3ykr7u0Mr3LsNkaIOc?=
 =?us-ascii?Q?kdzLuKIVzPN+j1GttZKFZaCX5dOk/roKjSt088ab0S8+mvxFFJZwvP+/91rl?=
 =?us-ascii?Q?MsjSf1AY32EcJYO3uNI6uXeCXsfhQeZn5S7/PXCPOj28a+JZeRNbnj46wUFK?=
 =?us-ascii?Q?UB6v/lOZOgVPU+kmXwcGPzLBH73HwIa1V7Cs8CEF4QOinGlzDbe0M2JsQbsV?=
 =?us-ascii?Q?5kogG5kl18crvOdQynzgvsfdaDnuQiGFoEjUxPbz86eD1G0XGGDsheRCKKfN?=
 =?us-ascii?Q?I3FvUAmvjJuoXw5VtXxnMhfOalSdQys8jMyEy4ee766YKMPdO5hvrx3/yJoP?=
 =?us-ascii?Q?4WV+t8TWgFwIOjT3kshNCs9v9W/ihY+SdndLTtFfZ2jcRZHBY7gOTuh6GRBs?=
 =?us-ascii?Q?C53nEbWC9opqldIiCnn4An1f0b3gIIc+lIuD0+OPAzqx1zKatlq5YvXurdu3?=
 =?us-ascii?Q?9RC/n417Q+Jpa8DCEtILZ3tkiUO8pPIq/HAlmMOm+SbJpVvrFH6conzxPY6h?=
 =?us-ascii?Q?Ma3fQzdN2G3vk0xcCxYzrSr1x3H+0aMiV3+YC04MWjGtmAdqqRZCIbUvOKsE?=
 =?us-ascii?Q?fi1yG3PkYzCh+7+mrDTjeiVCkr1KNto58iMMY4/3ytmJMC6FUbutFVTUmUxP?=
 =?us-ascii?Q?yEITl5qAWs+uNqN2Fg2fVOp9C3iqFAA8cgMDTB8LqkGN7H1i1GzvshTNaIdj?=
 =?us-ascii?Q?CDtdD+oSd2rHMi8EC0am6xhlD6oJjY36v9cC1sMG+TOi/AnuIaSHSnG63rZP?=
 =?us-ascii?Q?YoHX8LOBt8EYuxXtoXSzPVAtoJxtJvV09K1KkgLL2YxaQ3GYU3ojFwG6pnWw?=
 =?us-ascii?Q?ZY8CK2cpZgTe3HEGU5o4aFAmIclBPNiGuuDlxdHeuXrpKPl4dU0BIKfbS4C5?=
 =?us-ascii?Q?IHK6bsbDrJV8sa0VejZCofgmYal7DJzezbGhAFxLMtDHiwh+x/XEUBDYlYJX?=
 =?us-ascii?Q?crYvm/0LbeyZz+v74osaop4V0jbz/8UoRekxfVOmN63ztlWlrOVs9n5RtiMy?=
 =?us-ascii?Q?mvAFXPIsiWlt3DHzVDQEz6kVU56fGPTIx19qxmVGvH4Y/YaQvwgzZr0cPnec?=
 =?us-ascii?Q?wiYMhd7aW/VEh2LupRRt5Bw7Stf3NJK+kw/XdccLK1x8w/6T24tSVi9KRmZh?=
 =?us-ascii?Q?hF92+4E3CFgtYCuSiF3W4RHeqPjEaOXOtj2GTx7KIVSbCe5op27EKhwW0oX2?=
 =?us-ascii?Q?+Ld6zFDOuQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa352aa-8fe3-4b62-39cd-08da39a5de2a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:42:58.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJh3A1q/4QZItqkasWOc6zOWk7nwOnYbP3hU2eQ5/EZxft4LmR+KKqoxqIfA+LnaD5ZmGcb2SWVB1XBBHIVonw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 18, 2022 at 10:10:05AM +0200, Borislav Petkov wrote:
> On Mon, May 09, 2022 at 02:55:22PM +0000, Yazen Ghannam wrote:
> > From: Muralidhara M K <muralidhara.mk@amd.com>
> > 
> > GPU Nodes will need to set the number of available Chip Selects, i.e.
> > Base and Mask values, differently than existing systems. A function
> > pointer should be used rather than introduce another branching condition.
> 
> Yeah, it looks to me like all that detection logic should be split
> eventually. Looking at read_mc_regs(), it has
> 
>         if (pvt->umc) {
>                 __read_mc_regs_df(pvt);
> 
>                 goto skip;
>         }
> 
> at the top, then a whole bunch of legacy stuff and then at the skip
> label some common stuff...
> 
> Another thing you could consider is to have common functionality carved
> out into helpers with "common" in the name and then call those from both
> UMC and DCT paths. Perhaps that'll help keep the init paths sane. That
> is, short of splitting this driver.
> 
> We did the splitting for Intel and there we have a common, librarized
> code which gets linked into a couple of drivers. You don't have to do
> this too - just putting it out there as an alternative.
> 
> The per-family function pointers design could be good too, if done
> right. The advantage being, you have a single driver for all, yadda
> yadda...
>

Yep, I've actually considered splitting this driver. But I think at this point
it'd be best to keep what we have, and then write a new driver if and when a
major change happens in future platforms.

> > Prepare for this by adding prep_chip_selects() to pvt->ops and set it
> > as needed based on currently supported systems.
> > 
> > Use a "umc" prefix for modern systems, since these use Unified Memory
> > Controllers (UMCs).
> > 
> > Use a "dct" prefix for newly-defined legacy functions, since these
> > systems use DRAM Controllers (DCTs).
> > 
> > Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> > Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> 
> What does Naveen's SOB mean here? Co-developed-by perhaps?
>

Yes, that's right. Sorry I missed it. I'll include it in the next revision.

Thanks,
Yazen
