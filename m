Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEF695179
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 21:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBMUM6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 15:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjBMUM5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 15:12:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414994EF5;
        Mon, 13 Feb 2023 12:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/8Nxou7J3DHBtt7Mso9loSiJBv6VZ/6nKl4slLIfsmBjEhMKWGH9ekxtA/xN/Z8UDWmzMq5F5e4bynnIy2pzP6rGYQJ2eR6aLHN3892ggzLhJAXPB2IB+o3lueqQE0bcGd1Y8fjstP3Z2etaqUb4Yk447d7ldrygTpow40AdYlICgXEB9RaM1re+VeaBY3i1twYMy2x7cDZtodvk3J205gq+UpzTs7oEFVJh/gdXr9FUs2N5LYX1UFXQXxdMgrSv1WUKZsOnBIGfY8BMsGbuqh+oRVRcZE42lQHfANLiaI4gcv+sh3oCO8Bf0i2mosEMJblbjJN3Y286UzcOUvFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1myZNj4CMi9i/aAmz0DJ+2BFbbk3zqHZ2BFOgEJfT00=;
 b=Cs75zUYjiCmBaYnoaPIDAYk7GPZZwbTtJfVWotUf6b6wUDRdBkCqFjEJHBVMIV/tdtO3UMYDmLBwtORjMffC2mPsKg1vJ8MQV0PZD8xy/eG/Q3akMkqjZxKQxDKuRV+XZjNIuqRZOSvroF1+tAzvfSyBlFg/y0199NtJjWUVFYDyKWdjWrPplBldqlwmvHFbCF6u1lM7Qeo/Q2+yao7o4egXcou8JSTno+JQz7em1vE/het3LezDe+xs2al3cvOP2bZHJtJ8/PwTrkM5yHqS4g8gdz55T7lo3VKIap8eegWVCDv3KOajvS7mOKihUijPvMtKFDawE2+LVAvguDSGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1myZNj4CMi9i/aAmz0DJ+2BFbbk3zqHZ2BFOgEJfT00=;
 b=E4prZoUzb5bY0lzruXIIcv3E9/82noULqPF6eC2F/10GOAiCBYf4SRiBpQJc/SQay6vT6B2FLWZ/5YlYeHmk5nfzxTlTa5WwxVGNyTRnp98nslNYNm7KvvFziKIwte9mV6oHL8eMyhL3ifWqxNdScAOkwg3Rn/JwB2b4Mn2RJnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 20:12:47 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff%7]) with mapi id 15.20.6086.019; Mon, 13 Feb 2023
 20:12:47 +0000
Date:   Mon, 13 Feb 2023 20:12:38 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Tom Rix <trix@redhat.com>, Nathan Chancellor <nathan@kernel.org>
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: remove unneeded call to
 reserve_mc_sibling_devs()
Message-ID: <Y+qZthCMRL1m0p4B@yaz-fattaah>
References: <20230213191510.2237360-1-trix@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213191510.2237360-1-trix@redhat.com>
X-ClientProxiedBy: CH2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:59::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 339a3bb0-c661-4b85-4c8c-08db0dfeac9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmFsJUiogumKERp5ZoZ357YvM8KgR6qxbT4thoC30AiiSZf3qScEKn+UqQX26cYLNp4v4mCpUfZqLAn7iriwaPldigc/1YFBc7ZH2Gi2qVuCcvkWJTsN3LWNnE2k6IRsKTTRZxVOXJWnqjDPqvbD0omOY+PlYOtBHLbKqrexk4JwqAHxjXfn0K2OURES+zGnhyIpZsvdHdS6ZY9VwPWxhH1ChZIFgUJuTAicQlO1ssqawCCfVEbcyl4ue/pZ2fgoz+WWHF7R8OIM/IqF8yjlAu+YSbGSeBDExWE20RPWqrSYQzzqg3ZW/mZ6UQDOvCzqhFk5iDdIsogbBLuczUzo8tepwvSUN2/0Z4zUKFszuziE5dNEVeMzhdjdJORHFgI7nFQB6I3ZuLoIXGh2WIVaZMA0cJQVb7uN0IIHCj4MkeCxFdXiLr+JsNMOqCwkXgFnQ+Mq3gr1iqHjw+w7l9il/usZfhkz6bqT2+8FaSn+RZYjRNfV4YvMKl6guWvNV/p0D4DiyqTzubpyTEcyj480eTmqbdvus8csOUbFZ8K18H1NCQhCZpzwrVfhfA1stqDdL/H8vS23jWFAGF2llj2VzuWLMlWG8/vf58BTaDH1Ma+M8xB24PI2VjjaWg8V4uyNRD+kZNVEi08sMFpj8fTzXPte9TbsE6ZqHjpR1Pw8ln2ENJcksJdnLJbok5SNEaD7RwysJlZJMXENkehnP/PFF13lqzwTaCw+gY87ptycstwd4+GNw0s8+P0sz8b5xXTsVnnMFTVNxsr1Cy+ZehAXOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(8936002)(4326008)(66476007)(66556008)(110136005)(41300700001)(8676002)(316002)(66946007)(5660300002)(38100700002)(86362001)(33716001)(9686003)(6512007)(966005)(26005)(186003)(6506007)(6666004)(44832011)(2906002)(478600001)(6486002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ELMtUViILISQaHJdFBI7hasXPDdYJPmQzFpd2EUzWGOiTrcsveptAGeV9uSm?=
 =?us-ascii?Q?LljPmq5oOOdQi0bJnUVD8lX7ScB1zLLo/yEr0H3kSokT9YS/T+u13EatGC/T?=
 =?us-ascii?Q?QoytDD5YXb0TCtpwQFASm8BJvxfIhvTCaKKM9PBIuDpYFsW7AZkz0ezhswsr?=
 =?us-ascii?Q?2X2eE3Os3bi6st48j0epdI9HYJfrnA4zuMRrGAsLWdRDtDqCEswnh+K6E+ZA?=
 =?us-ascii?Q?8YtGhqB6RMa7t+yzanz12atM49wPLONtdc/uhMKGUr6bedqHGRgLb1Q4r9d4?=
 =?us-ascii?Q?k4b9Sh7HEB+Wu5S8wxRKmwdU8UbjJsfpdYLpsmK6s5cMbE5JPppOlY6tsx01?=
 =?us-ascii?Q?BGNCUlF8dxwD2DxJbwsgYPHCuWIEg8mP/Va5lO/xdqe2DPRg7Zj99pZQRSil?=
 =?us-ascii?Q?GsgTp22Y0iyUsssiSXhvCnQVmhRzfodxEXP70tJR46pyEGTE7AgpNHXjABns?=
 =?us-ascii?Q?iqDmKsZ7RGRCddIQhjDvNwX76aK+U9EGOXDnLGpX7KWKwfnE1v90lY/5GbCd?=
 =?us-ascii?Q?zGCakvfmmAFvOxwkRS/tCEffMieZ9LuAjIk3JRC0dmFm783UCNeZfDLSV/cU?=
 =?us-ascii?Q?FTUnmhZQlFWhMYrSXQkyuaht+CJFu05ZluGJqZgkPSip1K9dHzpsHxxZXzzM?=
 =?us-ascii?Q?Bnn9saPOV+AtYtYkVq8+ixmcd8A0Er8tx/wTdLDDhI+bStTn8IqcG18CU22Q?=
 =?us-ascii?Q?t7gJ8Q3qsqbWQzustdT0fBEgsrjE+UvuyVcvjuQUTLGMu+7V6QBTnQhVna/q?=
 =?us-ascii?Q?DE5jcxtQC4FMWaMuhR837UYRySTsZghlUkOVE6pKOI1SExRNllS7D7J1ocJx?=
 =?us-ascii?Q?dc/czma9VplRY6Mtdv9+t2t54ParGK2aodwo2kN8ixhK5tzincTNB643jKUd?=
 =?us-ascii?Q?TprKHRQbnFMXcVhNrHAtDud8dHW42YBUdWlNaCf3fUfpj5WxXjGnykDYxVoQ?=
 =?us-ascii?Q?6C9Jdb74IeY7UeWZA2oStCrGgkkVlRzsK8JtnmEML1mt+3SckTuIw68wFzU0?=
 =?us-ascii?Q?+qlDhX3RPnlTB7kL0+bxUxOVt7b/rrDtlfqWjQFdxFU+mnMgplYFmp1qHak+?=
 =?us-ascii?Q?16GA/t13ox2zyeeIB/gHKelxANh2Z7HWcb+efnBgnj9/T3S2sZQ3T9YHyfE7?=
 =?us-ascii?Q?jWiOWZLAzlpZ2MQpoWOUWw3Wi4F7tvFv4776yr7TMq+cZ7Xtx8bv7qzydmrK?=
 =?us-ascii?Q?idtrIx81AwFPOdZjJsVYa9uwCiOrNZPvSLPhhnwzsBmYNz8VzXsVthDEBr0f?=
 =?us-ascii?Q?LxboPuWjvdJ4qRYoZJOGtWlqYrTVtGbgMAXyq9c62K1ffhGQ0UksWtuESldb?=
 =?us-ascii?Q?/Cr8Zl7Ey+3A5gJfle4i7CHj3NW78PEh7bWddVN9e8AA2KVjxSaHT63rOcTI?=
 =?us-ascii?Q?eSPZ69fz2/1z4UUgQ5DxtNI0Ova8+m04sqkoLNlwWODjU1f5eTkUzzRSAXqI?=
 =?us-ascii?Q?xUyKFMYkZE1S/XhpdzkJftNy6tS1LlwKC3aVs9ghnnFFCUoMvuvSd71GhFdM?=
 =?us-ascii?Q?lggQjmyCmemHgQUFfFozw268+LzhTYZNSFS7JqrgkA8K5vEpx0m58HSCAGhx?=
 =?us-ascii?Q?F80B1/VU9xzKciWddzxFmatMQP3PpQLf4mdDPRx3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339a3bb0-c661-4b85-4c8c-08db0dfeac9d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 20:12:47.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55bqUxx2jeCSoGp53ZHjnfg1N3QGQ3P0bMDgtqhebkK5gHV5hN+EnVugwcbs0Uhm0zLOL1COY41tbm0E3jiqCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 13, 2023 at 11:15:10AM -0800, Tom Rix wrote:
> cpp_check reports
> drivers/edac/amd64_edac.c:3943:37: error: Uninitialized variable: pci_id1 [uninitvar]
>  ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
>                                     ^
> drivers/edac/amd64_edac.c:3943:46: error: Uninitialized variable: pci_id2 [uninitvar]
>  ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
>                                              ^
> The call to reserve_mc_sibling_devs() will not fail because
>   if (pvt->umc)
>     return 0;
> 
> reserve_mc_sibling_devs() is only called by hw_info_get() and pvt->umc is only set
> in hw_info_get(), so with fam >= 0x17, the call to reserver_mc_siblings will
> just return, so the call the call is not needed.  And when that call is moved
> the check for umc is not needed.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Link to similar patch from Nathan:
https://lore.kernel.org/linux-edac/20230213-amd64_edac-wsometimes-uninitialized-v1-1-5bde32b89e02@kernel.org/

Hi Tom and Nathan,

These errors are encountered when extra warnings are enabled, correct?

I think the following patch would resolve this issue. This is part of a set
that isn't fully applied.
https://lore.kernel.org/linux-edac/20230127170419.1824692-12-yazen.ghannam@amd.com/

Boris,
Do you think one of these patches should be applied or just hold off until the
entire original set is applied?

As for myself, I'll start including builds with extra warnings enabled for
each patch in my workflow. Currently I do a regular build for each patch and a
build with extra warnings for the entire set.

Thanks,
Yazen
