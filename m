Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6E4FADFE
	for <lists+linux-edac@lfdr.de>; Sun, 10 Apr 2022 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiDJNIn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Apr 2022 09:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiDJNIn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 10 Apr 2022 09:08:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DDF44773;
        Sun, 10 Apr 2022 06:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBI8/MMphzaOooiJn08HRUexCmuBqFj/10wM6/hhJkQ9xHBiM9QOo2MnlDbzSRaB9HpP0G0QZRpniToj21g1BwXz7Oi9hz1/vaoSpmqioBSMXBOV6rdEzFQoW80O4PUgHiwISO19mTU9BX11/2xmippWSTc/sQMw4FJD2p7Ytsv1bQ8VyFtPRGwzyyeJxLap3P14Inhj+Aknejg21eZnZ1tBo0IccaRe7PADSPxxJk66mQejNFVroZvsnQrS44O6jEfCW2Nbf0BC6pzAI+fcTi3d6DkGtz4Rut0pXaAkD/nenYtEuZa7y3T4vHCTLD0Od1PGxsYwBDTiPAGsJSHa1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upy9XV5vedWSYvRUcxWq1QOoLbvApinjd8h6fLN7N6g=;
 b=BauEGkayN7uTzsIyoSCUxQbxlX2ZhtDkdDWmpJ1n30/RwXn9VvKgG3PXP3JzJptsW/Vjur/GfXWmQ7MMCEl9b5VNyaGdG6QDLm7r2KaNqqIy4+ww516II7jxbdDLBTiy31ksc6tOTgCX9kd/V7Lm8ZPXnPROyUwTjHwzJ2tAKJ8K3uJava7XKTuC/n3yCaHfkSPnSbQsXx91h1ZTv/qSROajV5sWtc1EYdPkmA/z3Y2HPDwT89Vqg8bsS9uk3FWBsa0yK6HCQayVVls5acLVSHnGsxrUfqv/3G7HNyI8BepcfMojmrCJikS5/IxP67MSJN/bzk9bbOwfAPGSrVUiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upy9XV5vedWSYvRUcxWq1QOoLbvApinjd8h6fLN7N6g=;
 b=FhpCnCVkTwAyWHRqqLj9ynbBY8TJDM64UNaZWP4qxIPiYVsFyEZcL4pr2MuR+j9u92/a/QGN5XAt8ZP3uQUWxXYjZeejmy2BwPsc2bosjke0AuAntNl4Yc1Bc7O8z0cMIMUWXtUvy/H+gAJlVxSM0mqVKLRpvELtIhkJYMsUerw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB3681.namprd12.prod.outlook.com (2603:10b6:a03:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 13:06:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 13:06:30 +0000
Date:   Sun, 10 Apr 2022 13:06:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH 2/2] x86/mce: Add messages for panic errors in AMD's MCE
 grading
Message-ID: <YlLWUlt1V0lx52a8@yaz-ubuntu>
References: <20220405183212.354606-1-carlos.bilbao@amd.com>
 <20220405183212.354606-3-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405183212.354606-3-carlos.bilbao@amd.com>
X-ClientProxiedBy: CH2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:610:4f::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a441b3cf-652d-4438-ee29-08da1af2ee18
X-MS-TrafficTypeDiagnostic: BY5PR12MB3681:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB36812901F486196FC3158C19F8EB9@BY5PR12MB3681.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk0BU9P29LzLEv/crSBk5h2nhj2gxIAnzW69/dD1GUUdW22+eIGahCjCUlenzVt25hTbFv6KKxYpoztWA8Gtitrqk0NxT4zotIgCex1PnrquypGcz+Ki9ejaQvxlo4VZzVO/VDwxWKhQyoOJ0E8SKrOOVXHFhc1KxglWnKipWSMcdp4Fx8wRXdrFEtYTUNpYJvxpl4ShxUPMMmQhetuXx5bT0zNq/ui61BuUjp0pnJuDlQ1j9uVRFet0GS4d+63G6DHzJwNspB0kw3k4Kx6TmtU4UEhdc1QIzbV7KSmL3EFKEtl8CxqrHlzuoaNvptFQWCiYn1QpkmYiAKVUOd/6Os3ULp2TF/x1CGDGXXPlnM6O4y3QQmqBOzHTjJH9HBRZHdaXf9TKnG7bjWoL6SQDY0woyv8EcY/EsByN4bgb9R5YXWnQf+CgJxQa18iUGA6A//Z0KUkMp4PaZIl3d2wAhL1grNGXgDmVipRBUruwA9fu5i2qMAkWuOBgX6XEM4Gq5BgnHyZJbFXgrCbEWANY8ZitnMZW95MuHrf2tqblZ3qrpJ19YuOhBBUGkd/k3zd6RzT0Q5pQd/RgnXQuON8IinuF0GL9pqamvwMV1LY0Z4abiGM4yflOLLhYbo1Tc7bhWbO7gSA8SOaac2r5zc0RHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38100700002)(6486002)(66946007)(66556008)(66476007)(508600001)(15650500001)(186003)(26005)(8676002)(6862004)(8936002)(5660300002)(83380400001)(2906002)(6636002)(6512007)(4326008)(316002)(33716001)(9686003)(86362001)(4744005)(44832011)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmpYzyeNxD8dpl7GAeAseizGqZBfLHJZMVbZSdedW5JIieFQteCH1cWjQR11?=
 =?us-ascii?Q?1sBmbhlBjaFwtR+V0XHKhpVJkmWUKy0F4d/ycFI3Z7aypesSV4+PadlXjM8y?=
 =?us-ascii?Q?v3nmBl9qwZqTo0VPVoLZDwTeIxFuk64gP5WPyRSBH4CfaGNdh+ThTFQpcRg4?=
 =?us-ascii?Q?13HTLHH4PLt9Ew6Qdax4Z4IrtuCycvhg8Av0CG1xMNW3ARp6lAZ8F9ls91eT?=
 =?us-ascii?Q?mgMY0MZwlNRBKRVapZQIC1NkQiareiGDOFTl0ffKv62yEXLAMgG7nEWJmZ84?=
 =?us-ascii?Q?YXANCuhwdCRx7PDA3REH5XOL4eukgfyTCGRm3ftT0RO8yzn9HhZcalXR7IRF?=
 =?us-ascii?Q?e+deftvgo6V/c4VCVKJQ9KlFKwJV+HilfhNCfm/qtvA/vRvOOpxcpN3sd5KD?=
 =?us-ascii?Q?htxYXTUhxfYjSgg3EonTt/uwXQeBWJVmhvQSuzJ4TavucKkPgS5re/0WBtlg?=
 =?us-ascii?Q?OIbVeQEBzNPwX/inRTNyUpG6Azl0UHQaFgvEb++euwwLkkQ+4/QfEys2gNuJ?=
 =?us-ascii?Q?5j4T33pS+wImuVTTxeKDQhJMFKWRWXBwEFy640x898flUSF3hsFjehj0FwA1?=
 =?us-ascii?Q?EZAjAYuA/KdH+5SX34AI5srSYmeEtpJJFIBIxU46eEd1Ydt0d+8i5q8XbKSm?=
 =?us-ascii?Q?oMj1TYgFWZUgWD+Ns4j2GwCvRz7juVotrXsbE1JVxD149mQMTjq+ptAVvur8?=
 =?us-ascii?Q?r/tfUH1VdGcchu5d8g4Jxf9qdO2UmKhnctceQh2SBFoGU8BfCvcS6492DLMc?=
 =?us-ascii?Q?huzGpQWNXk/HKa91EOO/FV0zIsityfjBO4frk6F6GA1sFQRBPJD7uhEFyWlQ?=
 =?us-ascii?Q?+mYeJ8cK5KlsV5PxL9jeM0PlqHx1ZyxjhBV7eDPUmuoZidTulAdeJ5HrCPPo?=
 =?us-ascii?Q?Y3P91sDTZrP8SVxzMK3JjiAagz6ZbOlW/DNXvozHAiIhVNrCbbAL/Oo9b78x?=
 =?us-ascii?Q?dO3ZwCFcQUP+tbOjsdfwmSMJ7d9XQTkS4BoEidzR33SXu4eV5Hwm9+OTV/Z5?=
 =?us-ascii?Q?f5L3aa6iY3xZvhvxJgrIaAD75zrPlLT+8n6PjKhIopLd8/nhU9BlazJtEFf0?=
 =?us-ascii?Q?fSq2kcQ6Gc1UBrNfW79qmBeyn6lzXk4jSaAo7Vbjj4saEAsOZA8gi9q/BTZ6?=
 =?us-ascii?Q?TQCzQhwMQacCG1PjO4io7AMXO2NoOVkco4VajIRXgHhVzlMphuHfdgZapnZG?=
 =?us-ascii?Q?bfc0UWLf39KUZbDcW92jE0McjjjZuZtNkEUG7pFOn2q/VeeKPcqjick/RN32?=
 =?us-ascii?Q?1zs6BFwg+/EbPz6apcWiB16v/eEwkCjg1mZNU/m7bH/BbIaJWbfmP2mdxf4a?=
 =?us-ascii?Q?G2kuqI40tmq5zWJ3uVSmWLd5mPO0znkpYztCjJjjfwcrCQfgVb9w+cV0wMvK?=
 =?us-ascii?Q?k1SHz/k7JN/0TEXUumUIea8nNy7kbRBAi8xHhAbMef0SRTCzufHye86IH29c?=
 =?us-ascii?Q?n0il0tQNqrHVcX+aLdro+RYsG4k2zsusRCWOLmGXjteS67PnhxQmXpAoTomW?=
 =?us-ascii?Q?sISCasIycfY53T6ZzUs2zRCWNm49ERP1c2bK1rRBLdWvJ2Tc0EbR+upCuorO?=
 =?us-ascii?Q?dSrpifbD39DuddRZTk2AhaAhS1kjKomSfTx6tRmgK2I6dPLYvpKlLtGKWn5S?=
 =?us-ascii?Q?9eZxTCMCBdPsUO78q1DZ68/ZnIjLHaz9ovSQzrWOyDn8IJ2Sz9MmcffvOb/W?=
 =?us-ascii?Q?8ikUTBolybeIPYDjFOESx+/ZzMw7VmN1HVfsuCR64l2QU6xwaQLSFE4igaRu?=
 =?us-ascii?Q?Bv1DXsHIDQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a441b3cf-652d-4438-ee29-08da1af2ee18
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 13:06:30.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMFmuWbkgnF308L4fsp/eeEwhgMfF6C90IDkpJImVjCW7OC1OMjfvvB45QQt6sda9CDRvZgsiD1d6tFPWG90kw==
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

On Tue, Apr 05, 2022 at 01:32:14PM -0500, Carlos Bilbao wrote:
> When a machine error is graded as PANIC by AMD grading logic, the MCE
> handler calls mce_panic(). The notification chain does not come into effect
> so the AMD EDAC driver does not decode the errors. In these cases, the
> messages displayed to the user are more cryptic and miss information
> that might be relevant, like the context in which the error took place.
> 
> Fix the above issue including messages on AMD's grading logic for machine
> errors graded as PANIC.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks!

-Yazen
