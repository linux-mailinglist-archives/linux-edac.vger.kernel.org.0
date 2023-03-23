Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708A56C6C44
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjCWP1O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjCWP1N (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 11:27:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F6D1B574;
        Thu, 23 Mar 2023 08:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFTP+RnpdaW7N8SYezoGHkovgjfjd4LAbcUMy7EKjJmfBjJEz4iO87lpspH2g3RpVyZpgAnnVS0hhqxYeAF2VnhJLELH4s0aKE9J+xRLhyLhcq+rmIP/6k3uRTZxL8mQqdgOHYMXtVH84GsxsDmk1vwJ2pSKEQ4z6jvR5GjM+BNqEJuOuFiXqgvLN94hsu+ugUaIPLs6BJi+UKzoCS6ycV1KqoToMDx3k6vXTRZdn8SJMYG1X6ztRTdoqJ6R/vsOlZELQPCsw7PKETLpAErfcnhIu5K1gis3nUvAZeidTv4YV83YSbt3xPHZXrW2m9O87L1rfa/DUaZefhnI0PwZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FwYwe3zU1p2+ieKfEP9HtYrteHDThs/+HGV9B8iEO8=;
 b=R0Aw2pzT0lXgwVjn5CfUzW2ukNh+MqJOqr2XajzaClnKYCXAP9wMHWUSwDsGiXgS6zSODjdMxrsxNicW/xAJI4XbOz098SOoD/HKZkTiOzOsimiwtGKcSQC2QKRgCTomw7qBCG5yJqU795htHqYuQVXcfrh8KjhlKg27EfVcQWmlzvdrJ65q9HHn8pUfXfquG0aNWKoQwgElIoo7XizbqH2anVprSMdPLySbVxrEFpP8FR2enyz9WWHeHoDIT0xSW0Z8nxRaYHHMZOLKtTVlNjJe16YCdbWn7d67byPKyTTedAP6F3VVlGe+XXTIKIn2g8f6Y5JlBXJeYmilpha0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FwYwe3zU1p2+ieKfEP9HtYrteHDThs/+HGV9B8iEO8=;
 b=j7oO9JggkGYh+kBIfB++bPwsxxHGW4yPlydRye+AVVkJ5m9GZS0oeAicpwkkVc6pJgNaInpcx8GeMiPBpuxylv9t8V9qGpfDinOk711wNG0/Xb71PjxKV9+s6YkZLg9HogMvu1aD4ESAZJZysJ1Z4H/UgCLu56mEo9LfTBp9KsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 15:27:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 15:27:10 +0000
Date:   Thu, 23 Mar 2023 11:27:06 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Message-ID: <ZBxvyqb5Mnt13341@yaz-khff.amd.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-5-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317172042.117201-5-tony.luck@intel.com>
X-ClientProxiedBy: CH2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:59::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ac2e2d-1079-47c2-6d8e-08db2bb31202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu+sCh8DvuDaw/D5z2XVs83bkUH1icqR7yrUR1Kt40UXBjs0SM7fggIRC1B62NodN+Yz8Ds9q7B71jWzJnfY/qoiDQERKwHaEdEGDFEdxPdOYJsuMcInLnf5MM2MJXms7pfPvTbFMQ+BioUdjy5didM9SXtDTc06+hKs4vCCn/C2u+hlkob+VnU4PKuHJFHjx1GgW8HzmZzr/2kH0CSq67lFQ0QHDt3aWHLpOHj7l+cPFXa08m6vEbTR2qqFSWyj0lw1GJI6sjupLBSXR6S0svh+1UWkBXVumtUxeMVAkA1l/FcShrcgPNOkH9FHJnLVtg5JEVEy6sdKqcersI80vY8TstRRhEKNRICfPJlgULAd9jgDbqnD+gNSZKyIOrqycoFcCZHA/rxjsYg4s6RwcnDIhEYmC/OcPgWGqWqI+zXUkFLJuYM8SZRqPb4o/faOHnpww6+hvtAtRk0Tan3BouRgyjHaD07qB+9frUjDqSL+D45T7qNQxaxL0GlTMTSY/74OrsYaUyMS0rTepJe6xJ+MdTNKHpakEZ3RhuWlhACErQGmV78UtrE77xgqsyzqfScJRnxYeXLxiTc/5xYkknO7/ZZ4zb1/w74JEIk5IgR+8hMhke4WprL870q4Sz24WdnuFFjxmlkTJ4H3w3apWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199018)(66556008)(8676002)(4326008)(6916009)(66946007)(66476007)(4744005)(5660300002)(44832011)(41300700001)(8936002)(26005)(6512007)(6506007)(316002)(6666004)(186003)(478600001)(6486002)(86362001)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PqA7GAeOjKOzqmZ8co4CXN4gs8kUwvEP/h5BQVeufoNyRDqj/VoJemtGQA+/?=
 =?us-ascii?Q?vbhAHjpbCA0EnOJYhm5ZYJUR5uuwQCBu42f6qBoHyfTxyH74la2nR3KzNVx+?=
 =?us-ascii?Q?1llMY/iIQn1kQeXQUtTayPeGaSFeu1zJw3wCbtxeTlJYtTdI9fNVdE5juQYB?=
 =?us-ascii?Q?CSCUG54qahzFlOcaisRB7cMtzNULiWt/45yJv3/nv36ttlyOPITNotccghlI?=
 =?us-ascii?Q?ifNI8WctILlg2JJ0/rTzJ6qelOsdk+ClimGv7HpVAFuEWAzYcqBxuCflOM9O?=
 =?us-ascii?Q?RsfhHLnSSaxTjs/SzY1EHorhli3bM36zdvRb1oGU5c5FN57ytqqjZA/llB87?=
 =?us-ascii?Q?iT565JqEEE7GpeTr3aGb8gQbHzqGL8wV25VO8DGgq/0uRpKE2yYeLuNo2E97?=
 =?us-ascii?Q?oYSVyxVOYrcW+7RK8Da+Pbaa48XD+zti8v+Ylexk5IRigatrv1PfnoZ/0krX?=
 =?us-ascii?Q?DjqZWEtlWhZ3/bfPltWo4f6ZCoP6qUNiOGmU8DD62XqNGYG/RrMrQliLUc+/?=
 =?us-ascii?Q?70Ydz6Bhzwo4sDtmZvJtaGZrIMSBBkxdyYoJKi7zKY7CqyUz4hQCav8nVI6A?=
 =?us-ascii?Q?jR84fTWayx28rdkpYupxw5k86WduWbwmPwjuaNSIuEyBOji8ybtL6FzrY180?=
 =?us-ascii?Q?TxR1jHfBC6Ui7dsUq5chpQKKYg0Zy5Ya37KVUTMnCYfkXASerB7JPY+3tgRW?=
 =?us-ascii?Q?vEm/se6dTT/AcOqD0h+KlY1A2td1D0wMPUofq8hqsYKKSNnfwrX9LlAz1pHv?=
 =?us-ascii?Q?JXa+xVof1XfP/RWO2z4roRwPADcohArEVVibifh9JMeJ4t0FWY3pbgitAe9z?=
 =?us-ascii?Q?z7iMdatNH57Ey5wJ4qF3euEuBhBTQa7Fgu/u6U5XgXjk0K/9dsgJUCBk5lhr?=
 =?us-ascii?Q?93cz+Q55UnlgBkbVq/c3NN+v8/G7g0mTqmZOqr5AAy0ijRy6tlxqopkU43pY?=
 =?us-ascii?Q?G9QpeQrDKKOyTGiJs6NGbM9llFD7P6Anhs0qFAELDZN1SYpfUeCDYWBS2NIv?=
 =?us-ascii?Q?uBnnbwdKVYbi6VOIKki11dohjnMpqA1bDRn2zGwW579DR/CGVJNADOEFWfUR?=
 =?us-ascii?Q?XCGAx+xLRE7FCcqLXa6rc8iNdDaG0mJm3A1rGco5N8iMdeZZ43uvzaUcUycT?=
 =?us-ascii?Q?vbt/iOTET2CsZxSKuk/YiwKFaSN4HwmgR2GZO5FLLdkD8LBjYclKy2uNb4jy?=
 =?us-ascii?Q?s5jqhgDEWRxVHfwyXQLi015dc9aC1+PAsH0R+zkWrrVrPLtDQ6JgIpUINHGn?=
 =?us-ascii?Q?yX4SYMUTqiVMYMl52MJA2YQSArtzWNcGtMOb1Ak8jBk/46FRUK1CQZmlA/Vx?=
 =?us-ascii?Q?XxEehiT6rerEP0s8w+d4IKIspV80YeVfwxmWDSbaNXlo7VJBAtsI848/tc4N?=
 =?us-ascii?Q?UEB/L744CbzM2HeS1MXm3BI7HjRsNi13ax1pwhtfIiji8zX2mHCflsWzJa0m?=
 =?us-ascii?Q?uCGmLj35uqQfveaLVJCk+nUCoGVTaIfP0rVEqJlpeP2EoawSLNys/15q8TJb?=
 =?us-ascii?Q?NGN8y9EE5NtCSRI6wFOppLwGQ1GoG6fArCaL52J/yEPed+Op5Kt+PMks9Z4T?=
 =?us-ascii?Q?PZMqqigrRYJJe3qAS/7xCmgC6pNW+2HOTGiZaBcl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac2e2d-1079-47c2-6d8e-08db2bb31202
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:27:10.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENzP9MWasziyYojsZly9KrC+yNnfpO37XqKESqeGDSVcG03hWxI016pTQ0tUucrMAs7JQ1UsCm+X34Mj0aFn+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 17, 2023 at 10:20:41AM -0700, Tony Luck wrote:
> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> AMD's storm handling for threshold interrupts is similar to Intel's CMCI
> storm handling. Hence, make the storm handling code common by moving to
> core and removing the vendor exclusivity.
> 
> On the contrary, setting different thresholds to reduce rate of interrupts
> in IA32_MCi_CTL2 register is kept Intel intact as the storm handling for
> AMD slightly differs where in it handles the storms by turning off the
> interrupts.
> 
> No functional changes.
> 
> [Tony: Same as Smita's original, plus changes rolled in from prior patches]
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Can this patch and the previous two be squashed together?

Like so?
 Patch 1: Remove old code.
 Patch 2: Add new common and Intel-specific code.
 Patch 3: Add AMD-specific code.

Thanks,
Yazen
