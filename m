Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136924FADFC
	for <lists+linux-edac@lfdr.de>; Sun, 10 Apr 2022 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiDJNHG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Apr 2022 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiDJNHF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Apr 2022 09:07:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DA2FFCB;
        Sun, 10 Apr 2022 06:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFzy+OnwpcOzbo4NTNV8CsqGt6y7POPbDbel4AiAkb/PDZloBXDQ2GbPP+JtSMKGXBlkI+EdVdptYAMcsnfvKkofZEUZia7CylA0L0MBuH1STCjpz6ACRIdS/uW0wDjqFX6+lbp6r5yrLnSLCU/WL746XtyJMJx5kJsf6Z47+t15CE5wtYBjwJWlWmO/uiXB1JP8x2RiSekrjPdP6Zc1yjQWTzzFWZYbScYmoqhGcOq4ah0MY1oPbQbxXEUtLNQiymWEZYyZYi5ob16ju0rdo2gMh1RR7ycajuqNLPXwXy9AprXHwsLj4JakDPFZ65uQqPalUZSdZwX3XimFZHA+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HR/423NIrmo0xvg4GHIVWzK4yFrCZ+y7ek1ayjbo0oU=;
 b=RmDds/j1VXVhs0C1nfXxbO2OdFtr7LhKCGzws3gGhcnQdz0b2/234ObF2fi/S6PWvOcj0kBoMZav6kuCk7yuPixn/K+E4UN9+5MjHxs8pAPMry0PSU/4Y8YvzOlW0chm4+heF6Xp5l7AADWglS4eyP+/HvHIj94KhhTColYY/Z7Nd+NZWibRMW1JHhPrMC01vsb2plrc1JVpp+RXjSk1HUWJk0y9j9Sr+uiefwUbU4tfC3x/fBBF8GnlLrqCpHyjBf6NrzOLxTyYlnvOO5p3K4RPl2bhiJoDbcPfhoOFiHu5Hkgc9eUNVGfOGHMBvcN+Q1+43qjkvAGGCP9qoI0/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HR/423NIrmo0xvg4GHIVWzK4yFrCZ+y7ek1ayjbo0oU=;
 b=5nEoC6c84/se0NOFA8CJEHQyuLHioRi7+xpeJxyEscBTA4HExzr3w60gdN0kno91SQrgKA9z7xpasz4XSwPKkkiM2i56KRD06Mn4gnLwLnazAem0tpE1F4C6kML10y66e1VAvv/96gLAwuU8InKmU7DuMixwA0dup11VkisPdAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 13:04:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 13:04:48 +0000
Date:   Sun, 10 Apr 2022 13:04:44 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH 1/2] x86/mce: Simplify AMD severity grading logic
Message-ID: <YlLV7FKJZgrKOY9Z@yaz-ubuntu>
References: <20220405183212.354606-1-carlos.bilbao@amd.com>
 <20220405183212.354606-2-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405183212.354606-2-carlos.bilbao@amd.com>
X-ClientProxiedBy: CH0PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:610:cd::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23e009b3-8bb9-4e7a-a7da-08da1af2b144
X-MS-TrafficTypeDiagnostic: BY5PR12MB3681:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36819C6FAF0DA006CE0C6369F8EB9@BY5PR12MB3681.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hx1cvex7yI2tuo80otmtzU5LZhOUp7DFEm0d6WZDdFDLkomalRmS8Y8MKvgLZEAPK26UlI2rxedyLM3VEYoSWEDxaci24/nw2/Mv9ZmwyUogFUngHptPLeqa+F3V/SzHJVZ3tDchoECtmc4dbdYz4NFrz/Pub4fqqAV1g3Kw9H+RNbxtnBBx7smYlA7en+pRaRLkCX/ccpJuqCP35FJYRsIKOkntQyVe+sai9g3eS98LfI2B28AUay9hiydtJp6ZXWPMwuHrx69UyvoKennOEMAEoq2cg9PQhByE9Hf3VXJwGC3vYE2rYmcLmbvEmNngaUVUztuo0KUTk87o7pjHEXwoPhkky4UYsMJpwC3NgUq+hynvbx1vZAsRxaGjrELzbHuaLPKuHvGB63G6d0kiEVb6qv7Z7BExKqlGp1A2oMRGRNVmwIaQwjY/wr8ETggIKXwPrl9xloymlDW2V31Vjmrn/TEHyzqBMWTP72PqAf9PIt1qn0ISJYzEFOJ/8pK4TNF89TwHyDmbioTR5Ih8bOdJn+pQXcLioK4X1XAqWLlS19yYCiavCp309Mnb48sbojM5LO8KVekA0ldAM25MMlIqLLF12EX6iCNotU0DGCpCvLq8utwEKgzxxSBOUCNLNwM8jZHdcoF4H6UtXGtllg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38100700002)(6486002)(66946007)(66556008)(66476007)(508600001)(186003)(26005)(8676002)(6862004)(8936002)(5660300002)(2906002)(6636002)(6512007)(4326008)(316002)(33716001)(9686003)(86362001)(4744005)(44832011)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MNE+Ooe+LlV210gyUBsCwLs63aRJP6vZcALjCdXo/kApbb4J/0nGnYIGFHTv?=
 =?us-ascii?Q?zPYk6qrZ1fAcuI7/XZukbd+6tBLYhCG6PaCoey323C9PySFdF3WiADxpDM2e?=
 =?us-ascii?Q?nsk3lL4BzXmXM4BqoatoNSvB5CvvGv5OzDACOcDxBzednVSTompwhQtw3Eya?=
 =?us-ascii?Q?K2VwttemQpWlZLT4YM/jFPIpiLi2xYtytVw+AJjoulnfIrpBiyn9M+uU4+PC?=
 =?us-ascii?Q?blc8Eq5PW45E63CYRvanmNMmqLYKdqFDuOyI/csJ/SA4L9vDgMZfTSJQgn9p?=
 =?us-ascii?Q?GWk0ZM42z3AAMEWZ/idXLqVQs/z8vLD90JlGgkJBrUE4Htk2jxXTyq3oqYPa?=
 =?us-ascii?Q?OXvjBCSPIdyMPyKJ/ICZDxEn14Ap7/vYOPhRH5DqBw6ztOz3U2PuP+p9izcW?=
 =?us-ascii?Q?rjsJPVd71PWzplJ0te8/5YCUTofU7T7VSF1xG8hPEH14Ky+/ek/W8TDgX3eE?=
 =?us-ascii?Q?6TBjdzOLnhWPZjGatfT5s3n6sj/+21QF/9UU+mvfUCCzjXTXHyLRRZmQXvp9?=
 =?us-ascii?Q?CB0KmMuIDPlKXxJUvSj0csBNi214zZDEtSKBX/0yZsCMjo7qM1qkxZZaNyF2?=
 =?us-ascii?Q?WyuD+uUZRE17s4MGMJ+NgboAPpUu4EoBi431czWZr/nbslnppfMwvsVcdClu?=
 =?us-ascii?Q?EIgN9Vds0+doTlv6ui/FUo8/llgY2LQ8SBZeDVVXHyDvsQsR7g00ujUsMIw5?=
 =?us-ascii?Q?Uyz1cncI7KVurPYsZgeEj6NSrN646Wb1gH/2XaZPrDxkjhrhNPZNwwJRuAZj?=
 =?us-ascii?Q?iLdqKQUBsPEfSMzPSpJxYyysdD/2VsfVPDOth0AqBKr/eLsLKsXuS4qrtAlB?=
 =?us-ascii?Q?3eZ0xkI2D9t2BVNCI+ZghenonBM4rST6K35mFXZgwBRq9y30LuPh9fPoIm7D?=
 =?us-ascii?Q?eq7HpGNsMC8zdrbPIKfURI5OEgPB5KkAn1poRhEN9+lPYMZKJl2GTqWibHCN?=
 =?us-ascii?Q?z2uZzeLSLT3eabAwb3JJLO0eh2Tmg+z8bLSq+UZFPdqYH97gFTpqx6QJ8hSp?=
 =?us-ascii?Q?OB3qIq4RepbXPWhCt5bfNZBdv6Zwwf83vvIc4UIYWy5ZrmHFa0MzdvyDjL4r?=
 =?us-ascii?Q?c1VeEuDE0SIilrimHyOw8y87zZoRe8K8pBcm3gdSZhxrucVuqKVojQSzORnZ?=
 =?us-ascii?Q?4JBC5TlSARLVNPmqAHN+pfs4YAPZFaZrFMso5WiSsBtVL1GP5OHYdxbWBOQh?=
 =?us-ascii?Q?n2vRIGeIHfjaR0Bc8XMW9zJYxFQ3Pdxz1A12onJ2giAyHHdVzyFsk4y4RRTa?=
 =?us-ascii?Q?Ff+ocPNwlLWa8klbXEj5QHS09IIymD7tWU5f0wKOYoUtEh6zD3lVxzzvvV4K?=
 =?us-ascii?Q?gPGbZdbjngtNgcmHqmNS2M39WceLzzTMszolpzSVw6T7M7K9+QAmwicwCfsp?=
 =?us-ascii?Q?rT7Nt421wvp3vndOOxN0/glIHg36kVl7fpyQzM7d7HOy+PgU7Y7h68IiYZBR?=
 =?us-ascii?Q?YoGh4D8ht7xRdaIXWHBQeNgju4Io5l0XzCE5Qwtvx4hmrfE1bCDMCWcISxS0?=
 =?us-ascii?Q?Anz7NI3tdlYTbYrchbIQNy/gFxn+68QF6H8jG56TUbtdXTGb4sIgB8Iq5kCw?=
 =?us-ascii?Q?xbo1k8tv6vKvZg4kNiq1+Njh36SgbmJVnT8fcUSDlL2HiBjbyJU4JL00yvpH?=
 =?us-ascii?Q?6aAanwbm61qT60wj31vgVuzGgN91sdpmhUOsAusMeHpR6uBAC0EQJuBM7UfP?=
 =?us-ascii?Q?O/pa5T009P9STuy6xizmRuf63Phmq6hnJeYQAhx7d7B7rUNQdHINzcQJZehe?=
 =?us-ascii?Q?kgobXvyFCQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e009b3-8bb9-4e7a-a7da-08da1af2b144
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 13:04:48.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: palYSNkbmCopOT2YiEHJuOOLpSVgJ56hU9hcMdiyr9HJKmAa4gATJ10+dIBx0B6Q3xkpgLx2/ZnuxOQEAQBwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 05, 2022 at 01:32:13PM -0500, Carlos Bilbao wrote:

...

>  /*
> - * See AMD Error Scope Hierarchy table in a newer BKDG. For example
> - * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
> + * See AMD PPR(s) section Machine Check Error Handling
>   */

This is now a single-line comment, so the /* */ should be adjusted. This is a
minor issue, so please wait for further review by others before sending
another revision, if needed.

Otherwise, the patch looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks!

-Yazen
