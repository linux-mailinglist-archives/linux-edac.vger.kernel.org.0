Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6C4D3BB1
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 22:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiCIVGk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 16:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiCIVGg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 16:06:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A0104595;
        Wed,  9 Mar 2022 13:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRpt43NhWtFoqGtJqfhzk6TTmkqzVV5I6VeNfB9/AaXXa2MzHRYT5/grEjctzUDnZsjbm50vSpGJW3kPj8iMt9YPh2tv1FL/v93BkvskORkGYjyt99hCUs2I/hVfWmcVc6PXR6+kxlPgeHT1KdW0eYCY0Dg1eOV8A+u7xJ2SN/+EFoXOoEzCnQEYuRJc0/JvCeJdK6w6QognhurKZ6vXZc5nBgY64vTAQmidJd3lZZU7uH7uzqjV5XdT47GPe85lLQ30xD+prx180kTeWkbLbVt4fgqm+j13RBOTyeMkpxXb+Bmv3Mq0kzU4kCKB4GZ3U+TysKAN0Mk5WMkW9Tb5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obF0+DMQxesUte1LU2GML3+R3XealUGeK7ZSAExOSQw=;
 b=aWkUSuuFU5QkjG/dQq7bzD599JsxVv5dXgW8sleOxBsrJL2nnhA/LkufkvFyHgqk45cC6CMtKKi5cO3OKlbXPMKlpWOVnu+kqoW3JwLPk3EEuTxF1nFseVzLYNSX4Stk9AglpgTYtuX/kpnj8jP670XRlrE9E78w+JKUFVoJC/iJw23CyhebUQypSg1hc4Y0D7Bt5DS9KdMCfGRhZeGPvgcV1hsp5FVGYZbwzEpj8sjqF8yNhLQlatkORVomD5Jedf8Quzfvlocpb4LD+hjwyf4aOjj99jFIO6QyJitNsJyeAqVrVn0bqTQzvUx9YPWDeUYCxK7+8wDxMsVyLg8emQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obF0+DMQxesUte1LU2GML3+R3XealUGeK7ZSAExOSQw=;
 b=Y8GlaEMRpMgwtQfix3zHMEHp1g7+X8s0vQa4E2eSVg6Q2ZrMphCugjA5UrdCGAc6arhAUz95ERNR95vC2rBRzClShYdA/vTaIMwPHfj5TNTsgGq3cZUk53m0KGGUKjQom1insF0ORUGPhxIjQtxa8GRpPIgKsOXTGY2WhobyBb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:05:34 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 21:05:34 +0000
Date:   Wed, 9 Mar 2022 21:05:30 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v4 0/2] AMD Family 19h Models 10h-1Fh Updates
Message-ID: <YikWmqJ6y4V9yXHv@yaz-ubuntu>
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <YiTezZBrQ8PVu80E@nazgul.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiTezZBrQ8PVu80E@nazgul.tnic>
X-ClientProxiedBy: CH0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:610:b3::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7d52417-2813-468e-5ef8-08da02108daf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52473A99B156FA00462AC853F80A9@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/W3znMsOP864C7UZScdpCg3taYB7aC4s6/1MzvQO65ETmyzLKJFeJcg8UNXQjQvqSYMXAdz/2t/SqJaMXD7vISr/1LhEg6YIZPt3Lq84Cku1a/KIxZxJJ5fe8kOMeVSxN1a7Vo5p4vXhv2lQE113RfZ08lr2rcNXRnHYAC9h5CNN2HnxVVvk0bOdTZMxjByZboWFme8uvDJCs6g1/SyNCOzUH4Zzj1yJbjXWXvn3Vd9+EkXrbJZMh1ouTGb3hnGYayx7mX11eeFNlrZsVo2Y/9p1ym/puPyEqPN8eeEjtRtf8cpKCpMuU0NsDzBoMrzpwTHW1+p6RA2jLCXnC68Zqg1/0C6mlyJyy0Ab81KqGdDQ4jYLj9PHc0/iz68esn93zzXSYw+SgjHVIu74rw2Lp5MEF7NDjKRtYqbX+yke6FZmyV0j/yebcG5aGt8eX9tiAqDuUWtGE8PKtTUY/ATvgFJOQV7UE2kO0u1B1/8sLRSua6oMoiv2vBEu9cKGNJ8zFhOE41eKqcmJkO+Zoir6WR6vz/C0kwdQDg+JxnYS4rPttv/3rFcBejaQWZlGRReyX66iWXrr45AENzYiT/UykGn1Ho7aNpZSeWhA5heYSV7XDAC1H68wLcSCWPWD/46MhWVSra1WAmvP+f0X7rmiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8676002)(2906002)(38100700002)(508600001)(6666004)(186003)(26005)(44832011)(5660300002)(8936002)(86362001)(558084003)(6916009)(66556008)(66476007)(66946007)(33716001)(316002)(6506007)(6512007)(9686003)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fea0chbmdhpiC5FgjQumjKTIvjP0GyVuP8KRjZeufNjfBzETGA7ElBmvkubT?=
 =?us-ascii?Q?qFv/guP1RFFgns+zE2FDel/lmii9WhHFnJYb2S00A+VdovcLQHpgbZ3Dyb5e?=
 =?us-ascii?Q?BnrFGYx0f66rjg/q8Oalf5VhhhsEK+uc8C1DmXeLo7uqhJg26QPNCb1/I4Yr?=
 =?us-ascii?Q?v9YsnkxnC9+917KxNYyNv3vNaMxpK1yA5peGDXQ4hOOPvxT4c5eYhlp6ZHAl?=
 =?us-ascii?Q?Ku4DTJmwk6MzvC+rEIKgNamBlrvaAnvywZUjRCsjnty92vMTZRbSQ+2oFu5G?=
 =?us-ascii?Q?fsOR0l+XVGsRP9pBBQhTZgH8YbIFnvrR0PF4enz0xjQh3UNly2rCkZ+FKl1A?=
 =?us-ascii?Q?9pwHfoMnpI7UHJSBg4FmMUTlOmSx4WrPXLQFpbii+X8h74ZNojgjae1lPIeX?=
 =?us-ascii?Q?GCG6LTO4UMfnawaolQWiXMbgB7xcYcg49YG7gZpw+WIAKOd56ERY/BFd9dm3?=
 =?us-ascii?Q?Lzb0Ww9phX2CobFHSjF8g+HgqZmIc8/BynIzcpE3tuRoxX11priBYJTE+60z?=
 =?us-ascii?Q?6GiXaHT5/V68BQLQePG04imhnQgp3dIzWQ12RIQiurAKgLG0zbiY98L3DKj/?=
 =?us-ascii?Q?D1Pmp8/zau8w/bZ/KYGytldngwihY7ojlb+WTqQP/bvyl2GNuGcnQPGSCYMI?=
 =?us-ascii?Q?jZuNYUN7RzfVY/uIgNh3qDtrbs6kesHF5wl3G/Wmb6q/L72Jj90/VV/2CrCW?=
 =?us-ascii?Q?pJKWZQCIRffLOxLHrQeU1np9B2F0PNqe1JwEiMP6n6fdAwvjF8PDQkKg7aik?=
 =?us-ascii?Q?0Y8rUEhZ4d/9hpRCOvuQtBu9ucX8cVt88/Pnlbw2D0BKtY51PAv1p/A82cUW?=
 =?us-ascii?Q?WqAjxmg4ZTBFviUG65XvvL+Vk58GfvxxSqmSeZiuZQZXo2hbwEDuHlv5tnXj?=
 =?us-ascii?Q?FPjuD7aKneYNVvJxfyH+ZpYUa9W6tKZrrZaK9kqTJ+hpekqDkY/DGTXwIvoC?=
 =?us-ascii?Q?zNGA5ChY/6GPBpsw2qSH+bIPaoOSPAPmB32OUJEIz7dJ/Til/FPpRVat1Dc7?=
 =?us-ascii?Q?AqBe+wTB8C20HvtFBmN4C6Tt70/mQIfSJyIu7NoaaVfmULIqLQeOxuuIy/pt?=
 =?us-ascii?Q?M7JlV5SP5BqQxvjxfE4pZ7wBKOZXXS2aftRD9H0BtqEh/wGh951HUSbl9KwJ?=
 =?us-ascii?Q?hDotiRkSvM0nRGlparWbp99BOn66+YJCT5ZKGDT1hNfEZe81sXA2xWtVQWTI?=
 =?us-ascii?Q?HiHzA5Zh+pjutn1YNx6Z4yL4PImqY5bB+6oW5+q4PIzrgfhfawJEnzHSjO/c?=
 =?us-ascii?Q?TpJCzDERi14dO7wytQrZjlsWe7OlqJQc9+65GkGUkVs29+eLeWU4wt6OhNv0?=
 =?us-ascii?Q?saE/vpKtD4HIPgpNqRbhk7Oz8RUfM/+AuOFMOHbCfYS2clUe3Q/+AezMZdlK?=
 =?us-ascii?Q?If5Yf4T46FhX09ksQ820cg7JyEFqnBgSfMBwjxRmzSozH/DMe5UeX1cJYTc7?=
 =?us-ascii?Q?U8/3Ycck//o+TvD7GwJwz+VcN/c3e0MR0/vm1fnAgge6JdxWAuZFykM4IGPv?=
 =?us-ascii?Q?J2fLkclNFR1BWtS00UMbiZe1HbcxkcENIx/mbTEtc3hc8OfTKrmMg8idUxNu?=
 =?us-ascii?Q?W+vSn+b7YJTZDPLjSvq1hEaO3PhFToJdRMZfCUYxVMs5nHXX6L46GyECexQU?=
 =?us-ascii?Q?0xJq82eu/Podt0nEj2C7Uek=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d52417-2813-468e-5ef8-08da02108daf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:05:34.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfVKxIbjdjPM9dQiOeNOJEPF/nnZR3glCN30V+mtIqB9dXBRjva1uskLIp+jUxTbaq+4HdFagzymFj808hCpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Mar 06, 2022 at 05:18:31PM +0100, Borislav Petkov wrote:
> 
> Queued, thanks.
>

Thank you!

-Yazen 
