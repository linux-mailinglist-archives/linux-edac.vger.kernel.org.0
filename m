Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766271FB3D2
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgFPOMO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPOMM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 10:12:12 -0400
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF97C061573;
        Tue, 16 Jun 2020 07:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYbs7WbaqcgOHowwTAFIOYPW4eEQEU82XDIEbiNd1g0lj5GckgC+wBSMCDTDtYj7ygft/UaTlDX+25rjCCu9E/Fom6pldOwB622iqbJdzR8VzKGIA5DjuhfQN+litakTsvkjnH1qXc0DxR6rLQifGKiLVXxoDvxQIXswaybkoxJeNOY1dDDAtbjr0vRIfdM+PGRO39U6dJIAKO1isKrATkfDSvhW76PoIdDPBr3+I5ktUkask+CmOXdHSbMPjMFv9l0Kxh341NRXpVYbAftOI5XEOO8y3xPuRoYvP/zTDIlE9k45DkEmP+qxOha21PGHjlz4f32ZClFtnHLQVWH6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rWjLFAz6hSEhrToELMwJOaMgwtLNS1qpS3Rq9tn3fA=;
 b=JtMm190/ooIKvCrmZmgzI2liqWe2zJkNl+t9yrxm7P1auhCDq9w/nOVkF2vCnnPkey4sJ4iqJvmFftJJpwSZNHsr/pc8NHtSXbvJmyAFygERAkeo/Zm8YwS+37PoUUnwm0gpcc+r6mSmD/kQ/FEvX4hksAjqz4NQ5cciyHovE6hYWNcCgUnYILfEUBLeMM5GpyXqtuoD53pFcbhxQ75gdHDZYoQtiIXtt5tMjx6nTlQ7K6koclzyWEwW8W0UJvFu5xWGLEB7Xr7ErWK1OhhPc0Pg+PogI2DehbyvhqL35VJAou5o7OArWtzhZp7AKMWrJ3uTTbjFe8r0JmE7SBaiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rWjLFAz6hSEhrToELMwJOaMgwtLNS1qpS3Rq9tn3fA=;
 b=2MCb+1GD7b1twn0emi4rU8aQI0ExgYyTi9Lq4CTQUxL1juI/nfq5sVbldZ6+Pb1rHXvP6CeqR8JUTel5+6fDY+YA3+FQd8/18158u/J5pi2a97X61xlVE79MlJd5Via9nmkfWJgfjxnOx9ZFRPcGzkY4c2SzES6c/mCB0/sBJN0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0209.namprd12.prod.outlook.com (2603:10b6:405:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Tue, 16 Jun
 2020 14:12:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::2c67:480d:4505:5314]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::2c67:480d:4505:5314%3]) with mapi id 15.20.3109.021; Tue, 16 Jun 2020
 14:12:06 +0000
Date:   Tue, 16 Jun 2020 09:11:59 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jacky Hu <hengqing.hu@gmail.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 0/2] MCA and EDAC updates for AMD Family 17h, Model 60h
Message-ID: <20200616141159.GA3963646@yaz-nikka.amd.com>
References: <20200607043709.48178-1-hengqing.hu@gmail.com>
 <20200615115950.GG14668@zn.tnic>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615115950.GG14668@zn.tnic>
X-ClientProxiedBy: DM3PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:0:54::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by DM3PR11CA0021.namprd11.prod.outlook.com (2603:10b6:0:54::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Tue, 16 Jun 2020 14:12:05 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7b44a5f-e426-416f-d141-08d811ff400f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0209:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0209B6E60025CF1A1E7E73D8F89D0@BN6PR1201MB0209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueqhyWaaY0n/TSFhPQ74BQBnRuOREfqv3nRZGfJm1KcgC/q9mPoFxrX01od/mz0ta1hH5LxLNh+i3Xof4Jby+jNvw8lEdAUc2CvHD1SggrsaL5vbzAwi54JsKXwmiwJ4aUcg+8JzEOgFo37CDU/y0yu2szh1XkWe6DOAgs5dS7kkJqCURwwbJ/oOb49H2ipHuEkiygChQC0yvk1+ZlBu+C0RXW1B9TVd8XCRmwsH+W2Urn1t8iu1CSh0TNlA+FZsMVhvybDd8hneqEN0ZnbrV85ILpHlFcXvMwkRCwk5WCECjY93aWjqkzmdAggDJHIivh3/ItbQ2LTk3QaEkbnOEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(54906003)(956004)(186003)(86362001)(26005)(4744005)(44832011)(8936002)(5660300002)(66556008)(66946007)(6916009)(66476007)(478600001)(2906002)(16526019)(7696005)(52116002)(33656002)(4326008)(55016002)(6666004)(8676002)(316002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ImeaO1LG4sdVz6f0X3ocThl3gGMqxI9LYPl8wf0mTJOA703cpF6f0Aqjvu0BgnpKXpb/Pj66g2jfZodadxsdxKELXKUjJL3dsUQkQMGMssE1NrvrKAZSqMFQSa8ZnaHzO6YbfSLAdwfKkq7iKyGj8c8si47rbZ1lawfeRJ6Dayh6smIfkujm+d6B3cEa6BtvjCftkUejWPnw4FC4JABLpyWY21JExBYQzS613sq/FS+yDn6pbzMaBKhjZNE3mc/dTiCMOT8VRTYtUx2FiG9qQlwWIiYBMpQdWbD5O83nIJknsItMhW5QTGL3iaYPLzdWQTGyqjys/EsQGaBlwd3UC07boF0nzteBFYDE4+CmhbUuiMA8tSEOoqvcylqCP7VqIPjNJXkG26iWXnjljmdFoxic42sCSOWnoZtA3lqnbTQRQrA3Ik5Wp874/YXTuZ82V1TflM9SM/CnTUooapnMwkXWVyc6f5mRyVO+/WIrygY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b44a5f-e426-416f-d141-08d811ff400f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 14:12:06.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhMNsnr5nDc13NRjVf5EL2B4OVv05A9uDN4UXG6RG8tZzFTxq4Qkm7uxDt1/GDKqqxUxWCXO6gP/fT9NL/GFdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0209
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 15, 2020 at 07:59:50AM -0400, Borislav Petkov wrote:
> + Yazen and linux-hwmon.
> 
> On Sun, Jun 07, 2020 at 12:37:07PM +0800, Jacky Hu wrote:
> > This patchset adds MCA and EDAC support for AMD Family 17h, Model 60h.
> > 
> > Also k10temp works with 4800h
> > 
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > Vcore:         1.55 V
> > Vsoc:          1.55 V
> > Tctl:         +49.6°C
> > Tdie:         +49.6°C
> > Icore:         0.00 A
> > Isoc:          0.00 A
> > 
> > Jacky Hu (2):
> >   x86/amd_nb: Add Family 17h, Model 60h PCI IDs
> >   EDAC/amd64: Add family ops for Family 17h Models 60h-6Fh
> > 
> >  arch/x86/kernel/amd_nb.c  |  5 +++++
> >  drivers/edac/amd64_edac.c | 14 ++++++++++++++
> >  drivers/edac/amd64_edac.h |  3 +++
> >  drivers/hwmon/k10temp.c   |  2 ++
> >  include/linux/pci_ids.h   |  1 +
> >  5 files changed, 25 insertions(+)
> >

PCI IDs and EDAC look good to me.

Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
