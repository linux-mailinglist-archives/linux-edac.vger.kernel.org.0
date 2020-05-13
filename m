Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D131D18C9
	for <lists+linux-edac@lfdr.de>; Wed, 13 May 2020 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbgEMPKi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 May 2020 11:10:38 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:6214
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbgEMPKh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 May 2020 11:10:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBhVM4LBtxgz9BbvhKegp21wDubsPdjfXu5991sEIYNgwQAPZgJrRtPO4ejp0fE8QzFsVEDNeSB9W+l/2ZNE12dehU0I8msPOpv0ka22xVnGE0prBPmDKLnBrBXbjxYrnV6h7AUa7WtJe9OOhLt/wtGij7TM7MVC+W7BjlrDntonvF2XcC06qgIVIqJEfro9a41ohLOQFRlD6yTk377N4HauvHAydug1QXZ3OPpyA/kLrp8d8HfNMwIC6DWRNeItbo/eM7doY54pUmXp8adizPDyBs9yCF+3z/jCMgSQP+u3jk/rKgl0iJyHuuV1d76ixmo50bBT1LvWxh+2om1YTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3zjfUighGDyaqVMfmgLCv8MTKS3Bl1r/VH72/cdp+c=;
 b=HAN0rSb5fmdmkOiI2kFk9R2tFSyLibdqKxriK+VG8VvZpV6PY4IqeseJSqu6Bcs1Egr6LSpkR52miC4XdqQ9CdpiUZDvT9Lb2p5eIjrfJb2eA4kAeER0LOZ36PyEBCR78DnhUw55YM0/d2n7szdk+OxniJuvNmdgwtz5cbEycT6JH39n0WAQHC+M3r1j8OgHOi3fbJP8HwIzNlzwt33TuSQsVZZdCYEQ8QmfUDCuRCxGFsrmGxpTkGRqGDlTSjb1UAHdJh8eMgU0Y1EX2OYlTQFbd7NDOKl27XytATzbzTUgEIyWmIITKYp/YTcVH4Z/iSPawsKdGgYXDcs8VTs/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3zjfUighGDyaqVMfmgLCv8MTKS3Bl1r/VH72/cdp+c=;
 b=0N5b9urI1b0JsUx+H+svm3cs7mPOpzsung5ZXTi+HWwrwTWHJKvAVm6X49oYnmURHXEnYGf6ts3UW3UgJhN7cnkcw8Oh8eKpxQm8sfAwGsx63ycNQs8e8tNVRbgRrPHUFDxAmUQOhw6zaatgigFGunTHATOutUdk39iuUwtzORI=
Authentication-Results: ispras.ru; dkim=none (message not signed)
 header.d=none;ispras.ru; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1218.namprd12.prod.outlook.com (2603:10b6:404:1b::7)
 by BN6PR12MB1393.namprd12.prod.outlook.com (2603:10b6:404:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 15:10:33 +0000
Received: from BN6PR12MB1218.namprd12.prod.outlook.com
 ([fe80::b021:d7f2:52aa:1fc]) by BN6PR12MB1218.namprd12.prod.outlook.com
 ([fe80::b021:d7f2:52aa:1fc%8]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 15:10:33 +0000
Date:   Wed, 13 May 2020 10:10:25 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Brian Woods <brian.woods@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH 1/3] x86/amd_nb: add AMD family 17h model 60h PCI IDs
Message-ID: <20200513151025.GA3283032@yaz-nikka.amd.com>
References: <20200510204842.2603-1-amonakov@ispras.ru>
 <20200510204842.2603-2-amonakov@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510204842.2603-2-amonakov@ispras.ru>
X-ClientProxiedBy: DM5PR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:3:ed::12) To BN6PR12MB1218.namprd12.prod.outlook.com
 (2603:10b6:404:1b::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.1) by DM5PR21CA0026.namprd21.prod.outlook.com (2603:10b6:3:ed::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.5 via Frontend Transport; Wed, 13 May 2020 15:10:32 +0000
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10749e55-6dc4-474d-aa97-08d7f74fc88f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1393:|BN6PR12MB1393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1393E3F60259623C33307C7EF8BF0@BN6PR12MB1393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8smOx9my65ZX8xsdDQRTeiKyhvuG6oj6T0WEdbOLX4iScleRBnmPcANDKlXf12TfmWBLq29W+OdOWk7qo14XrVqzLEjsbpciBlWHQE4brRL90JJ1iTJPsTiq6PJt+Zw44R31yviN+/pgYPFzQYaVUP9L3+aYmSbAgg5q97Fd4b4WEWAPdC0+5uXky5KuZDZO/jaqO5kW16w3kCs6zE8Qd36cRCmX8XVabPIoomSzkTvjThAJYGBOoh0wSDrXX501lDplyoeWoiz+LBqkEkKx+vuPRuZGD1VeAuCnJhnpKjMYd9xsWe8Q/Xzd4VQYHSd8cD6lMDU1oD0abr3YOGDh82j3hVQd94ksWMauDqu73TsWbeSEjCfmJS16b/WprOXuciw/V+YhQGQ5N4QwJtyD1GIqnrGEyea6aN+xMK7y74zhMegsz6OoeDBr8leiv50WPESj1R5Fpuu06H8dZNiSMCRxQclBaTYlshzCWX8ELwOHWKUpsexwmwrcnjlMku+qXGt7D7Ff7es5+9zEJXUMVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR12MB1218.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(33430700001)(52116002)(66556008)(33656002)(44832011)(8676002)(5660300002)(16526019)(26005)(2906002)(4744005)(186003)(55016002)(1076003)(7696005)(86362001)(478600001)(66946007)(6666004)(66476007)(8936002)(4326008)(33440700001)(316002)(6916009)(7416002)(54906003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +F8A6MrQVLAh3HMbSiE/ucuYlX4A/7/ny8r3AbZrxWQW6zJFLCwWCfihHPyuUOVZGKfD8i9HnMvlwKAJrYSiW0IfoJ7ZtQPwPb/vpBhkQEMbNi2mHHtAhKrS3K22Nkh3+snAqPyDXx4TZ1nEjeqgWJ1zPyWvteGFM3ogn6PaHtqV7BKekhV2vkoeZtaqYTFDqqWzhNKb8FlLfiDPLAwe7tw09uijRGZL40anRckg52vwx4+QrPM1oOXQ6SDe6i5/1UeGjsP+mtHALM8TEn6oeki13yXGznSwXerqLYnXwEL7DChpqiOpG07cLQ+9S56jYF+Y4Bwm2a0cG0BmqhQwWLRhJB2lpwtrSnI5tMvXCeajSaIMrLWN1jWGaAoKuP/Lk4HvBE/djFmg83k/TJtB4M/VJeUxpMGUWZFuP65AmM4s1pjwFd3dPtC34OMBqrhMQ/Q6qQ5+U/EYBODegvjT4SyRbQy90zDSqgu40Ec1hxQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10749e55-6dc4-474d-aa97-08d7f74fc88f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 15:10:33.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkuPtawZZbfWRWQ/4m3x+Xb+133izr333EggAxv75WAvNm2Zj3iBrNTvIuN5o8dC3ajee5yOdDstoJA+04sGaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 10, 2020 at 04:48:40PM -0400, Alexander Monakov wrote:
> Add PCI IDs for AMD Renoir (4000-series Ryzen CPUs). This is necessary
> to enable support for temperature sensors via the k10temp module.
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Brian Woods <brian.woods@amd.com>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-edac@vger.kernel.org

Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
