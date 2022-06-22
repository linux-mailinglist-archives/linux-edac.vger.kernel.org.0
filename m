Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8599A5550E6
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jun 2022 18:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356636AbiFVQKa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jun 2022 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358698AbiFVQK3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jun 2022 12:10:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D2236B52;
        Wed, 22 Jun 2022 09:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3spAyNiBQQ9gy2zkbTiyTHHVUZaL2shtVpPyxO95c1+zXQi8Z89Yu71ISKazCXWD0IoCN1oiiE2ZIjxDTF1MCAWgNUUzCJbOwKvbfUQZuK51TzdKFURg3yH41OoS+L0A6iDhvi+JAdlngsKOBDjk540La18xCXMLUfr81BcVhX9HS3cz/5VX1xoFYdFBNZ6/2sn+8vLtK4URn4KT8Ew5kxJQEv0gNNSz70K37Nqu2cI3Lgd7buGWHQFh1veVbBONm+INnqUXIpIduOXT22qRWjbzwIHkD540DE3c0R3GR2SFjegksDU3avTVVmqRP6bGODSE3pGzBshrcePIvFq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDwyUOjBmQoTOyRiJ+JgPjd8Fg4JZQK13QHeELxEYdc=;
 b=g8JUmtsz+b3scU4EKLT3/1dirDNy62T+OCd5BlVZvXCyqXYZBysFf0ENrh93j4Q2LDiQJLrCbFX1Ev0RNceL2oIU4at2NDlnfd/SE5mnYonUbNopMwTB3Pg8mpnwqToD52M9sGQ0bMRKEyDXzpY3KnZFOKA8BcR1dKkXw9z+/2d3uIHZECpGXZsceAgoSKX3X+ZEI2i2M5YyQkO08x+bnCyLS7e7txpcapLpPeMKNnYY63nslPEFiQ3HZ/lOsReoifEOP3rkoWOeKRhQhEx1Cc8gem73tv9mzsPK3354Vgu9SdTVyE4z+vd/Y0QQ9dn3+xNcSVRsNMKZbO2xsIfArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDwyUOjBmQoTOyRiJ+JgPjd8Fg4JZQK13QHeELxEYdc=;
 b=lVT3NS25boKrJ89pHwhlDOZqdngGWrSGiJ4A3O4XxP2ztOA9OySvz3ZNj+jgxirPWxoXkJIPMiEtJO1NvmqQg7N3CZ+6yxz9E0Vxr36D3NSIEND9YzLJg/Kwi8eLE/HvFT6T6tePhBrTPAbPd2oKFnZhmifty4ya3qBMY0Eeylk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 16:10:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 16:10:25 +0000
Date:   Wed, 22 Jun 2022 16:10:22 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 12/18] EDAC/amd64: Add determine_edac_cap() into pvt->ops
Message-ID: <YrM+7tii3AK00mvh@yaz-fattaah>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-13-yazen.ghannam@amd.com>
 <YrCed0NnrVUjKoJh@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrCed0NnrVUjKoJh@zn.tnic>
X-ClientProxiedBy: MN2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:fc::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8924b8-2d9d-4a78-3715-08da5469b76d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4056:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4056D2C1E987528D8106563FF8B29@CH2PR12MB4056.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9WFe/Sw9BBViEjqFXu16IjRzp8CBIzGBmUN/pbhiqz8FC9pgx1/ugSNmNWG60gcHLIILsrkNuqubZmehn6b0fEEst49NpRNVtHzkOdDKqRTJ0AbGmNVWdiPMuUG2ETuDMV7nSYwRmfTg1kJRfGJhkpOs2J6RFhVyevKzKWwm5mVmoLB3oA0y+k/TRc852eNmyWi25RNY1YZbTbeDph5WKF7p4st5B9EYKvpWl5ab+QeKrS8f4JGoDZOAICobVcxgD7JJUNbPRad7RbfFg0lmvL5VBNnJnOrGn6k7zMdUlbNmrg/DbmBFT0Kv0kWXW8pHemE4++h+4Q5V7uWEiNNi8Qq+HMuIX6tIgUnoxmo2EyElzvkVrIsSAMsL3nRtjMujKqHDbEgBLv/JJbkYiTJi2JURA4w14wrMh0bM7tKtuur49LVSCVDgIzjW7gaQZrw0sTyLz/qItLzwunDrSDJ27RHa+gNQcKV3UTCORGH7d37CXeHheByK1Bz/h053CyMy4QNpAPZ9cVYHCaMdfsSqldnLfeESUhzP1givyG//fF2gqUNj5nm8tjEUTviXkRRDN8wP/r2ZHTMYzUTBzARvKxt4RUk1YTjUVprgBsHN9Sg5YXsCuBf3lGgD4f10Dx9vntcmppb3OPXqnXyYjRfs60GeBPO6hHy6zEjnvwZFU5ek8WQesh+DS8/+iX+iTxusFJ6USvkh2LhADowcL8pz4xwhzYM5BCyueTokz04BONkmgexmlUps1qtUdqHoPrF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(2906002)(33716001)(83380400001)(4744005)(8936002)(44832011)(5660300002)(66946007)(6916009)(4326008)(6486002)(66476007)(66556008)(8676002)(478600001)(316002)(86362001)(9686003)(26005)(41300700001)(186003)(6506007)(6666004)(6512007)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w2BBG7m24SQITW1Y2dYemhsuX2o3LdDTHrWsk953jUR6QgLox8rAFijGljQm?=
 =?us-ascii?Q?cA7uxC6jhJZCPWxp5oTTWOU05mejmypxNzshxKeMFc1UxHiC157QSHVu5/iI?=
 =?us-ascii?Q?DXiVTAS8QQGeqAnlGzhvAC7/UWLjnDfpf6Y2dW0FOEk/7axK5qpLt5Pb20hq?=
 =?us-ascii?Q?WUDShY/uWNO8a7Fva5k3yxqm+cigHI2KGgi3GFsq37sFLwrG3sIZTkfczMcP?=
 =?us-ascii?Q?dKdpjmcIJeXJ0Ck/NgECW5BdhBFicCYvB5IS4yTfm80GE+EGQIlFoUHgtWtv?=
 =?us-ascii?Q?WnerBaJtyJOXptlVtWPL5KFFWqqzZw9Nk1Wp8wnuuUfe7CzYV+DSowVvaCrM?=
 =?us-ascii?Q?huBB1RmFUA0EQKgIPA2arD0GUfDhu3wAszA3GBnFI6M01wMS9OJXs1fhACzA?=
 =?us-ascii?Q?5qte2w0vYfUlfcs7pyYQQyMluywb3un5quHHF1dSp9IwxMZP9JZDsWBeVrZr?=
 =?us-ascii?Q?jcSLNMn1CoB1VJ/bUv3qIxvzjx/TfjH6xeBduUVVnKQGN4CgUb9o8jg+hmiD?=
 =?us-ascii?Q?F6lMjqGSoCQ1S872IqJConrYJVu89bRe/CktGdtRKV/FCMo8fvj7VfyIidVn?=
 =?us-ascii?Q?n8FlAg3m2/N8ypnEnAZ8huD/AIXPU0et8XZ/zdKeuH5Zd2Ly3g4htk8ZR+uV?=
 =?us-ascii?Q?l0a/OjO5pIqwS7gj5M6ajO2cxRKAaqPYyUmPZ00DXOYoUvF9Wx2Ib2LnVc9A?=
 =?us-ascii?Q?jNEBBNIA4h7yjK8Zkhqp15YEzVa5713qxpl/I2XOBgpNh9eTNc3fpfbmt50Q?=
 =?us-ascii?Q?XyniGN85EwxYuulNm2y56dMfGP1Vm9KTpLD6AXiLmwz0wd/w+UXuaYf6f6QQ?=
 =?us-ascii?Q?TmwXzwqC7fRsS8jXISm4YXAmVKlDvmU7aYBWY+U+VN7nmeDQqBZwS/Y/iCBH?=
 =?us-ascii?Q?kvj9+g1bNAq7VffCpzO1wpMuk4OpeOD1+2Mmbrp+XDjAysSXiIZvN6xBL3q9?=
 =?us-ascii?Q?+OKwvfmfuw6Kbmtn6LODVS0zP7KMsXJs1tAgVpONy08G+koD0mnE9uV8aNI0?=
 =?us-ascii?Q?v11+2mI62oCW3dZDJXwnwzUFC7hIfmy+aWDffPV4x28MSxm3H3rQDLQXsKDx?=
 =?us-ascii?Q?veBqGU8FBuyh8Mq29OGK88BNVXOfrpzFc7g/fKxVbcMy7kCIxEo5UT714ldx?=
 =?us-ascii?Q?/uKW9pROjjPQMU7OJbI0cSAQ9WvOjdxf9Nwidqkugf4bzauIaMGdW2F1WIJr?=
 =?us-ascii?Q?0rJWtDEFAL7dn5QLSRmSlLceOMuSWiKYwm2JkFncttinW7V6v8ISdLZLTJd6?=
 =?us-ascii?Q?Evyi798WE33CBqMT+Bd2gPPBFwdaqvJqeTkHIGj4/xGm6Rxp8249uUQehjwu?=
 =?us-ascii?Q?2ZIcvrVQ1RWrSyUgJZpUffJWIk7lCdM4EYDNlYACZJvNWXIOUSyQnCPv4JY3?=
 =?us-ascii?Q?hocvz0BeCBkv5kwDuPgAychtZHRKnydhQHGz9/zN8lP/KyKJxHipYLdvhsuH?=
 =?us-ascii?Q?XjOQC0w2i0T1HkWdR0MgYXAOwhtt1hEgk++i3YncGQSGLUmu9twrPzSGMWct?=
 =?us-ascii?Q?SZmsyCHGV89gXJdjPud05LlQbbbVpkNU9qByiwSABHnyIXIp3Z/MP2LFOmAU?=
 =?us-ascii?Q?3iKPntvrqCFVI1vVQnDUBBlaD12EYTpIoglR6OduNh40X8VHRMucasDo8tc0?=
 =?us-ascii?Q?bv7LAL5nseJBcnMPnTktOj5mvjVpK26w1oblg820JKmMpwk3Bo52KmB9L3kV?=
 =?us-ascii?Q?Qnn6SCYqaYmHGbhUm+MdvbElz8rPG7YptlTRPQ9JaFwVrDiuRaMeGKE3l8gF?=
 =?us-ascii?Q?huDcwIWv6g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8924b8-2d9d-4a78-3715-08da5469b76d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 16:10:25.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjCHhC0AAejaHDzVcxT/XDg1d5hEHnwJ4AWQVZSSVq8/vlU8XVDIESoUC4i8cZdv0ydN9SGk7diBFxB8K32wCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 20, 2022 at 06:21:11PM +0200, Borislav Petkov wrote:
> Back to those...
> 
> On Mon, May 09, 2022 at 02:55:28PM +0000, Yazen Ghannam wrote:
> > From: Muralidhara M K <muralidhara.mk@amd.com>
> > 
> > GPU Nodes will have different criteria for checking the EDAC
> > capabilities of a controller. A function pointer should be used rather
> > than introduce another branching condition.
> > 
> > Prepare for this by adding determine_edac_cap() to pvt->ops and set it
> > as needed based on currently supported systems.
> > 
> > Use a "umc" prefix for modern systems, since these use Unified Memory
> > Controllers (UMCs).
> > 
> > Use a "dct" prefix for newly-defined legacy functions, since these
> > systems use DRAM Controllers (DCTs).
> 
> Please refrain from adding those boilerplates to each commit message. Do
> it once for the first patch and then no need anymore. It is clear what's
> going on.
>

Understood, will do.

Thanks,
Yazen
