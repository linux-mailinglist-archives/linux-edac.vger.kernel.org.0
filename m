Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65D275CBE
	for <lists+linux-edac@lfdr.de>; Wed, 23 Sep 2020 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIWQF2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 12:05:28 -0400
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:42304
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgIWQF2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 23 Sep 2020 12:05:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEBsFWBiLTOHE1nmhI2OF6SPyspfrteXqWk5jZsDzrX7FmkMq0Cm/gebxz59utzjiVTg2rGK1y4NWiLb/Qe8qs3qw2kB8krfFUNCGcCu4oRN+sUycvVcWT+sNYZaeTgdigagNqNK0K2IC+JnoOLczhasTfA/aL/njmBS+IDf6ubTtz+Sf2YXAW9W7zW3+dX93YTeXvF2/jlgT0nKvLh+c/V086AaEaY6IoduqdeS0+znqcqMMOEBSz922S2pNd44Y1/yTjwJaSwqRckWpiaLmNnkp7SyarI23QmN2mcsiSc0XGKj3fIProW4PgvxxhgtNIJwKkqYW3WinCTpDheGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdjyIRLfuZGd0LUng7Wj5V26iVr4CVpRgUQYoHWeMKM=;
 b=IuCCCA3M2ADaaQniEHAApTXUyn1XTu2lhHv2UG15osGDWPLK8XOKdBHbmdG9zCbexChMOPB9agBXAYY+d4MXSSKlzZmvjqz7azqMd5cYT1bHTN3UVPFQiyxLRcWlVCXwKKwDvv6XdnrdxUwfw31yFkRQsPviMWowhfHSsC35oYEuuJkUE2Lqrx3dHqFVMJmHIILCQWJcevIjXz0jX33YYj9UdP8eW78Rm7FcMU5A8pvXfqR518IUNJwsS8aY0EPxnmE4WheLntePEBtahEqFbDLFq60xUoOlWzQXt6VMQe3RRx0EY5Dxh2K01RnpcPflQxn1LZF+2yeM2+UIB/rklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdjyIRLfuZGd0LUng7Wj5V26iVr4CVpRgUQYoHWeMKM=;
 b=nZywFwJ9L2cSWa/zbwm8GoBCteZ5f2VEd7+hOZCSmx/cjBGU4r3DV8Fm2CKCR7mSc6S3YtRMWgq8nTwHSyWckTKzFxKXLZfypKbP2Ij7/5W/WVjosecpyQK7CAoYaigVvBkFKGp2yoZc+HUp/m5YKs/LCjteZ4ws5vB3Cz35C2s=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2835.namprd12.prod.outlook.com (2603:10b6:408:30::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Wed, 23 Sep
 2020 16:05:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f%6]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 16:05:23 +0000
Date:   Wed, 23 Sep 2020 11:05:05 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 6/8] x86/MCE/AMD: Drop tmp variable in translation code
Message-ID: <20200923160505.GA1684790@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-7-Yazen.Ghannam@amd.com>
 <20200923080556.GA28545@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923080556.GA28545@zn.tnic>
X-ClientProxiedBy: SA9PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:806:20::8) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SA9PR03CA0003.namprd03.prod.outlook.com (2603:10b6:806:20::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 16:05:22 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68a48b1a-57d1-444a-7ce4-08d85fda7a63
X-MS-TrafficTypeDiagnostic: BN7PR12MB2835:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2835D39494F48F8851E05E49F8380@BN7PR12MB2835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgCwv3DxA8VP2b/xcRNmmKZ5cFWRgFYQMSbCVYfs3l8tpbtMkOwpTouLycRVt4+OoxhONGssscaIUJSuKMSzY82y+F4hZbzLwz7lG78KgPFqrhiCsa5XBomQ48dGOuh8MzsvUWZyutAzGZC1XxJRpNBQe3ko/AoXMG/MB29kieklRfbXYlcl3vmG2TXs6unwrC3VLgKYoK0gOZlx1KZar0I4TuElUMpwQMZnLGNzL8ScVWNAaPXpJceTiffR/4a5rfrwb7X9aeg6mgpMpBgN7mXVmt+4FdfdyTd+iTbbamVDj8blo0KFuiHTZ1jKRCv+MFzMUTSo1jSFgClmFXn1xXc7arvkq9dPOH/gl94le4DJhEgRaeY/TgV6nXfAweQm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(186003)(4744005)(55016002)(86362001)(66556008)(66476007)(26005)(4326008)(83380400001)(6666004)(33656002)(5660300002)(1076003)(66946007)(44832011)(2906002)(478600001)(8936002)(8676002)(52116002)(6916009)(7696005)(956004)(316002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6+/mJ3FZkSLXrbZlNWmefvvoFtAI69KOjLOlfOLKd2YfQTrAG/wScSW6SsTsXRM8ZHOfNWxmN9/M411lYW/sQ8RBFg2OJebaf21m2TCySycv+wV7I81T5e4IWhkPheeen0rcFfGhXFaE8zDbmTZSTC/e58l/8F4u0luGXNJ4DdUExd61HjrC3CtpK27ZFJFoDBdk9f/pHccKwRg/ti/gWM+u74NcE7CqCdpIyIT5RX7t1ZVe3KhKVWRxkP6Kmb7l8swrCAO0Temhm8XNG5HJNCOD0ZGGYhMMsnONZqBop+2DjaF6ZbBb5p+5DQVwX7DYs9+vdkaXjmSUhj9/8FmmUn1toddhQe30hWlZm6pAKUVWF6locYPyhl/I5WSJM21c4jsGKYVzY8lH/vgQFw+7kghFGuChAPqCO0xMna9jQHwjkFjdE7nM3AkZOV4+wtxIxS5UAtz40Ggd3Teg0+y+EwswNYuVboyRYkaNJR7pRA7IpeJ1vE+j0WQ58zsz1t9xLwryCTWuO1yZvmhRAxyKRM2FbqhJzc3JeBNEhpGWALSYhN1um+HGpXCbmEssjifAUIAMRNtdNgIpx5TIoPOXbu9ezze5THJZzl1cu9qfvaCbgbBb6xKn18qjMeqTw6E8RiKqYVOlJ7upRw7xwc4i5A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a48b1a-57d1-444a-7ce4-08d85fda7a63
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 16:05:23.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvw/C1QA5kLbO3AsOQyqiJ4tkM5oMOElT0ts92LkfywsIB6eIzNcai6eiiJE4pR8Mbpp5WDk9uOkF0H++BHD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2835
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 23, 2020 at 10:05:56AM +0200, Borislav Petkov wrote:
> On Thu, Sep 03, 2020 at 08:01:42PM +0000, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > Remove the "tmp" variable used to save register values. Save the values
> > in existing variables, if possible.
> > 
> > The register values are 32 bits. Use separate "reg_" variables to hold
> > the register values if the existing variable sizes doesn't match, or if
> > no bitfields in a register share the same name as the register.
> 
> So I'm missing the "why" in the commit message. Why are you doing this?
> 
> Is there some reason which I'll find out later? If not, then this is
> just unnecessary churn.
>

I don't have a strong reason other than trying to address a comment in
the first version. I can drop this patch if you prefer.

Thanks,
Yazen
