Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB9587C52
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiHBMWg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Aug 2022 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiHBMWg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Aug 2022 08:22:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B33ECE3B;
        Tue,  2 Aug 2022 05:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPykr7wQFEXe5IGuKvJHcRlP+1Jew7smtFDYVITx+/mfBNshY0zMat4hSizFm2yENafCblh3RIPU1kbqQ1vPiAq5F7/txV99S4GP9RrMIYpABZ59fTcqfR/BIDTsjNJuv0coNem8256dnLoWt0Qct6yGMTOuJqbDiRHZ7IKRu9s1/cqiYGWlLCLP+a+UtF4B3wjsjE5yEhElDrDx0rxKyeV4xRJ540dfAN4p1x6VnGOQk44ubkNiI49l+fJ+UDR1V1cl7SB/22r1BMf2K1X7PMFRWQbDAi+x+NcwYCzMJQPssPelLgGT/hofNUn+blognhMnulc04cFL0X1ufSfK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELtx2P1QMs4d8s2Y3eoN53y2rxkWrIhjHLu7DFGoB7A=;
 b=D22hhm0Qw8rztgA28QdqRd2V3qXInbmQiQajemaoMkcVaHvYgENKcUCLmzXxLfXqbXv6RibqU1CAr2Mj6FDcv65/UU7e8k/DBvbUNjFt5aEA2cmsaAbUGQKmJ7ZRSbelXUNsiLItpZtg2PORlMY6gkjnloF/d/+6KRcDA9PleE2Yi52IeFKkWLV6K+Ji7yQVWhGlQK5QydUnErL9DQRy5OZ0dVGUnx2t3PvtEao4fjvyvLfN097BjleiSNepnLnUpCz4xotO+sXDnp8TwPkFTTuiAmb7GM0O/X6xqe28jcDTqEhuFosDCNQ4Uzic2CKVECZE5F8UaKQTysFa2IlZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELtx2P1QMs4d8s2Y3eoN53y2rxkWrIhjHLu7DFGoB7A=;
 b=cX1OD/kfmAEmTEOsqqT3XbMzkeWhcPH1TlAi/MjXeFS09mPMkrp9dcSCvhGkH2pvUi6nW/kA2KCJYRJyBmlrAvKQoYQTTui82Y7K9Hop0o67i0k9xigeKai8gTD6fwQir1KihcFWLdBiupvr9HbF9XCh4Opw/21lpKMUdjSe+QA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Tue, 2 Aug
 2022 12:22:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::899b:b076:6736:1b8f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::899b:b076:6736:1b8f%3]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 12:22:30 +0000
Date:   Tue, 2 Aug 2022 12:22:20 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <YukW/IltcCRwvSM4@yaz-fattaah>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtVlNrW58cFmksln@zn.tnic>
X-ClientProxiedBy: CH2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:610:55::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f861b7c4-cad9-442d-cdf2-08da7481ab82
X-MS-TrafficTypeDiagnostic: CH2PR12MB3832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovIYUB7XV2YQjV5Chw/GblnMRPbB2IzvTjeH0oyPvN1Uy0lWHMc3ltgJiacLSbqIt4cEIN8PhOQv3L1zFDoWUjzJLkSixK0ar6CBhf/ztkEeoErMUXGP4ToOCAvFJEhIIOXESbscSGsY4mJhc5dcn8r2kWaZfU9zTxUsr1xMUFikzJgYdHquFRAHKruyly2JXfQWL+5vg6sCV6L8zCbrCjED0hdrWc8V1rySExfNyYqISKrhpS/IrnlT2CY/kP1X0Pq61GN4fO//1jZFMkUjTXDoP4JfNmcnCi7lRu52GsJ3yHiW4NeKnpjYSHdXGkj90bggF6oskH3+PaGnzpeZPNivBX+Nm9ApW9ZgaJAgRvHGPYOZlKqXkESp63k0j73sy2J99p4td78H3K5QTyCBzhO6h+cFL048rcNqcjHTkcQiDLzoId46PRFwS5iNBBw+AtGnALnZReDvFvWcZwQWdwzcjz3A0DgjMAl4a7XE/OskjGsHkLsUgkTgL3so+QmnXpgubl44OoyVu9TwPYEDzoEUXPW7/ldABTj2OD7632Ft4jdAfri5R5djG9F1IY5u72ABVYe7fJBnHSWtpj4UB9VenmgeB5rrP1raWPTcaRKujztiMisqfZb81vTvk67DoIdIMHS5U1RH6sE5yP0LxPwO+SNd9tZXVMycmHQr1p7iF3JYN6l7SplrlLjKhY3J3QuK7bvMr+2Hb7SxOpkNfXilkr2w7LN+O3peCzCZqqQhdsGP8gVPSVd4KXs9Hdu+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(2906002)(44832011)(186003)(4326008)(8676002)(66946007)(66476007)(66556008)(8936002)(5660300002)(6916009)(316002)(6486002)(33716001)(41300700001)(38100700002)(9686003)(86362001)(26005)(6512007)(6506007)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvbIoDjO6XSM3665qP20b5hdykQw2ko1/jDrPqGPH4SGyI6GsR3YgtoF+Obe?=
 =?us-ascii?Q?X2uMhtjFz2yZu/bUjvlYbvea+EtLzmFeJ7WycZK87mevrYbdvNpVPaMm0THK?=
 =?us-ascii?Q?J2rC1m55Et909mH06FYpzAJdha1NMRUMZliBqEaKkiT9eN55EYLWGMu6lfQZ?=
 =?us-ascii?Q?azfyVUOVwZ+R8K0f5lOsMQQuql18Q7eXeIyrGoXo5U71Pu39W4XEkfzjWGtc?=
 =?us-ascii?Q?vEY6IYGtaEP67CRQ6zh+phgZf737o5khu/nu39EgxYEDKE0B6daimArQ72ue?=
 =?us-ascii?Q?9VNbtSfQyg4qMn8hcmvZLhDt5qRIeLjbVSQ00/VJ6BEGftXxrqU3hY/blMQP?=
 =?us-ascii?Q?WAjt886FctI+JGVtkvxuUMwLphZGJ2VO4mLjAGC2dOGAPaun0Tyrek2g1Rhw?=
 =?us-ascii?Q?RxJwvSH9No7HW8UbvcDmTQDNUyLQquJ43Iy2v4TBBC0xLj7WyjaZcpXGU7us?=
 =?us-ascii?Q?aBWiNQQNuXAzm2egS1BJtqCTe4QD4yTrHjCfpLfAgURhQ6X1m4FOK1OOToKb?=
 =?us-ascii?Q?d5qJMDgJygK5w4jRF5fTOo3qoWkzwU0NRom2oiZPQcOqdH50PZ4Cp1LNwKur?=
 =?us-ascii?Q?kyfVppF/GD2GpPfCMHrbIJ41l9LbHZbaWTuhr+G4xh/KX56ztvMh9TIQUCAg?=
 =?us-ascii?Q?lhF7nfCQUpnxSG1ryftCLkG2PI+lkpPcysavXKMjpsppbk+XMuUlJ6kCR434?=
 =?us-ascii?Q?tQbZ/feFOz6KVura+byAbTeY4aipZk6z2OGuPmbMiBfhxGTeZg+/HogSaXg1?=
 =?us-ascii?Q?Gq66TYSsqsZHRUVbvkVqn7cqvzrVO015+ZEYSx9WMODivcYEqKY1dQKVAkE7?=
 =?us-ascii?Q?R5ccgu97gPJZMipcm60kx4bCiBing85AURbm9GiC/0KAriq0iN5Qbih/SCPT?=
 =?us-ascii?Q?I/Q1i47KoIZtK222w5dDfXQgvjITOVCbNfUw5e3AC9dJblmmL9jUPxdvHDwg?=
 =?us-ascii?Q?3oJgVq6t8a4X6XFGxd+xGndbVhF6FqN+MOw3n/WNiPKxZNuWX9UvFJ98zZw2?=
 =?us-ascii?Q?A7M/KebM4H+RkIRlx/5vDOmmtX9ohnRkjCtUq6J7UwxpDyxHXghPHMEi+LSe?=
 =?us-ascii?Q?QvYkomHbNvFgBMAnqG9NRdfoVO5WPpcpw+G/32z6QakbvqfpIc7RS1wRGNqu?=
 =?us-ascii?Q?YM9NcZ6GQ10m70uWmwO5J4k1ALehsWPzrdczrifuJ77rN3wG5HlNpDIqRO2e?=
 =?us-ascii?Q?o1VO2oEXfiBTIhw2IpvESprzkCeZlTIShwmFgT3Z/UrxOLSXptM4m9qrSh+J?=
 =?us-ascii?Q?M/FTkOLBCuLQzB9/R8nf207lON/AKkzHVneYUQxJyye11AUnW61JVxX7zzIa?=
 =?us-ascii?Q?MwMZ1CHRn+AZDInLOtMht0FL1u44KeS6oJpebegMttc6Js7Zdovm0UwXqvFA?=
 =?us-ascii?Q?GyRPUZUCbMg/+Rna5pN9/71Fc5A/GZzOAuYyPuZzCZzUSfJ1J3rLe7IGAzM0?=
 =?us-ascii?Q?B5Ltt6CQRHBwdQnI+OzwjlbTV6GSmS90eRNlqbPGE+MhXbZ+fjpiQhlIbb/4?=
 =?us-ascii?Q?ElTg0utgo0v/NwnEuInQelNNrDshxSAGyOAja6mcShoc+IHH9ntVOLu20HL2?=
 =?us-ascii?Q?6jLhxYyRFB3CkDd7yhFirpXnZFUNvuiRH9lOabqX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f861b7c4-cad9-442d-cdf2-08da7481ab82
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 12:22:30.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWr6vmejPXyfOCpyuzUPLhvny//G5b5Wdl0w5MpzulJl5evDPG6EZcQZbwrvfqU8z8S5y9SniEgh0ueP/qaY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 18, 2022 at 03:50:46PM +0200, Borislav Petkov wrote:
> On Mon, Jul 18, 2022 at 10:57:19AM +0200, Borislav Petkov wrote:
> > Lemme talk to rostedt.
> 
> Right, he says __dynamic_array(). Grep the tree for examples.
> 
> I'm thinking we can add a field called vendor_info or so, at the end of
> the TP and then dump whatever fields we want there.
> 
> We can even slap a flag in front of the whole thing saying what the
> vendor info type is. But we don't have to get ahead of ourselves and
> keep it simple first.
> 
> How does that sound?
>

Sounds okay to me. But how should this look in the internal kernel data
structures?

struct mce {
    ...
    void *vendor_info; /* Points to a vendor-defined struct. */
};

..or..

struct mce_ext {
    struct mce *m;
    void *vendor_info;
};

I ask because struct mce is UAPI. But I think this is just for /dev/mcelog,
and this has been deprecated for a while. So on a related note, should
/dev/mcelog be removed and struct mce moved out of UAPI? Then changes to
struct mce won't affect user space, and we can just consider the mce trace
event when reporting to user space.

Thanks,
Yazen
