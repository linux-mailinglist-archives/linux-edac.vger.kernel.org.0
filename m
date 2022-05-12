Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D023C52502D
	for <lists+linux-edac@lfdr.de>; Thu, 12 May 2022 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353743AbiELOe6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 May 2022 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355361AbiELOes (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 May 2022 10:34:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7D0260878;
        Thu, 12 May 2022 07:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJIXD85Rllb64mDm9/fPf17Utw5cNFKgPtBRQM7anK3h6No0K3GpIaOODM2UB00PTORPkpK9Re9+fl1dU3HiapDRf3D0UtC7IAYeUaxj0GlCoOMIHr2DtNflU4xbWijUCyIIrCdquHU7BRhYhbROJSBqbPjbUjb5mPjJCmJF/KQVcAqopWnpWrdv4qEKEd9Mb7SylLmlQz+xPp3h2u81JFqA7WXVBgBN/S4pgXLBUHOEOIwu9cNUdZT2cj9GvgQUSyEqXGKGe7WZAWL88PeMDA0hfVgeuqfgUCfvLfYH2hXhN3X8yeyrWP1xR8KHitrC0LBeYNigvbXr8icFu+HKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvYobhNqO2p4rWepGr/hnx8nUwOd+JzXXLKLH+XUD6E=;
 b=MqeT6uX6OuBAlPWLpF8HxLfj75TgwKaW7EP5B9lewT0uU4DSWg5C97IuoGISA7JxgRsJhXnS7vTBLWARjuSXUx4qsiHZE6YIMEwaCXJseIS8a8zdpS7MppOfq5ju7t6drcOc2aA/FJiccvIRulE2OzVL5YsVrIYhMhcK43VCEgH7xFtWCaJu4a4KLEgKUjRsaVf6LuUfw+hKBZcFQmzY+i7aKcZVbCJV0SruEgUthniCeF+L1JpM/cDGS1NgHsnf6dCzjnZ63fmjG/hPn7TN9U6etkhD81GjVFdnjWQoymFO7QERPpy+XG5+jRxUTLYYeLEYrZ+h9NdLWf0GA0WzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvYobhNqO2p4rWepGr/hnx8nUwOd+JzXXLKLH+XUD6E=;
 b=CEycAi1O08BSku1LZJjrI08Jqvn7F4yb//Om3ctfC6p4ZayYXofP8rtKtYaTJIym+MlI146RyIB0xwkAblU8FL+5LYOkdyAxgvMBZLgPZUPnBe5XLiLtyLNweLvFzCT06542RlU/89+3hOQex6Jiqb4CASgno6PlnJMXLeaEDjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB2700.namprd12.prod.outlook.com (2603:10b6:5:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 14:34:37 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928%2]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 14:34:37 +0000
Date:   Thu, 12 May 2022 14:34:29 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 04/18] EDAC/amd64: Remove PCI Function 0
Message-ID: <Yn0a9T9xqAkWnPWt@yaz-fattaah>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-5-yazen.ghannam@amd.com>
 <YnuRUsAcnzT4Advm@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnuRUsAcnzT4Advm@zn.tnic>
X-ClientProxiedBy: MN2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3089e193-493f-4c64-c96e-08da34248a63
X-MS-TrafficTypeDiagnostic: DM6PR12MB2700:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2700CCDAEAA05E570DA6FE95F8CB9@DM6PR12MB2700.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhShIRdA6Sw+tnIVVEV4/N476+sMN34G91oj4BB5q5lKgxfZaXyG5PfblboiHBwsYrzZhb2/Vb+c9N+MohQSxbHeQwN3Bry23bErmeSvT1CPhcPsyMY5Rtthg33xusSBm8wvuUpUjGF/lmd/yZi5V8XR+H3J91rW6Noh/nCBHh7EKNc4ZanTDnI/qZJqqCu3HYy06kJgxLPQ7BCy37R2EHQmuPtE00Bok8dSj8ntskvNUC5maoUfMLISFMAz+6F0F/GDTOoZsZDxpnV3i+LU2dMZMs0JdmKulCEEJUFK3jB9Y8flLp/4CaUWXt0VIFzZR49ovftctAsSsGI44ax/sDhX1J6HnBKR8FVNJJw0QJeKgViqbCB4CYM4CoscCu8nXL08s35sogMNX3Rs3TQqNJX1M5XsbgqSwrwxQLEYh5QA3K8p/Bl+A4ZzusxbOnU2kDegKE6fE48M8TtlbdiDY48kI3tN7lzuE0t8Ehq6j8+JQejmmAywzlzxemSFuTEp7JuOnpmfxN28nYq08HjboOCtlkK9AVZOSgRG/60+lacz+3n5UaeGQolOYYSrr2DZfbuzkaRlVE9wKRjnI+uFH/cBYwFXW5YQvXi4heTmlgPMLa1bwauUcMyNZp0zU9EorbUAqlngX2gSoPBU2PFkWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(86362001)(5660300002)(6486002)(508600001)(8936002)(6506007)(9686003)(316002)(6916009)(66946007)(66476007)(66556008)(4326008)(8676002)(6666004)(186003)(33716001)(26005)(2906002)(6512007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FD51GGKFwOvdChhg/qxyk/+mF1NdhPbP/5q8HAi3dxs5YC5Arpte0OCYjEuS?=
 =?us-ascii?Q?agUxQt6xQCRy3jybm8bd/Mut9COUwAXtinZZFJq2eeQFe+ba7N7ZYt41n7N1?=
 =?us-ascii?Q?/TbbWxXfMDNGvMyqYUaqhkyotuxTq0OopGKZrd2OQawzE0N6nW2qJH5XcDE5?=
 =?us-ascii?Q?Yqr872rhYXSjoHEOwpzjuab6m7DPDqIAULG29d2HliprovIfGARpgSHk4G92?=
 =?us-ascii?Q?YhOQJvlw/mBmMQWfYvQErnRMJVYRIbycBagJVJEH26rnVC93unBgWXjrKlN7?=
 =?us-ascii?Q?SxsxVwg2I0L0qqytp0onKy6+PXiL2w+bAOFeFxfySY/KzClXQiTBG6ffr1qA?=
 =?us-ascii?Q?tRi9q0VW/6wsOht2OckoqJuShse4pCBwwKNJdQXXZiF9JPyT1lBh60ycTzOl?=
 =?us-ascii?Q?iO9f/+R73Ni2Xl6L/ssCYZo3k6cSOct+R0/mmPvFze1V4r6YSEKTjsRAvrs1?=
 =?us-ascii?Q?lqIksEOxUCxVVfAHsVI+44jWEg+b9MSY2U4ziV2M0fvFtRGuNTQuJHtODO9g?=
 =?us-ascii?Q?A3WzwaXPi+oFywaQzgsZgAMgxFIDGDMjhPVs3C6JTQyf7xTJY0fpp3L+eytn?=
 =?us-ascii?Q?UKd9kvKOyHNCs3SeeTe5MVR408dKVqrUTrbTbQTs34ub1gqKKSSOjF0lZDhr?=
 =?us-ascii?Q?EAYJ3cQSBeREhW5aLc/bwVV7DH4lNChFBHBQ/eWA+cTBAYl02nfzIRO2ad0I?=
 =?us-ascii?Q?tPrXaXWhz+6fYlceapb84eBN4DKgPUwJ7jX29389zHf5vzVKrDuE0M/hp0FE?=
 =?us-ascii?Q?JnHCX2XAYVi4Hj/buh5j3E4PYCvz9sI72Qr4+P0wifXVumNVaezBQjpuo4Jx?=
 =?us-ascii?Q?8NkvHSNdh3bEZxo1IY/Mv94V6RiiKy/33vGkFDY3HWgYdQUqOzedk+FR0v5F?=
 =?us-ascii?Q?VbEFwpx7qBIxtMt4HCNqPgLIIWCSmMmdUaBY0JxcYX7h+gFKzWOkw5gNmiZC?=
 =?us-ascii?Q?UZpKpUn3GlOBBrNmQHwdoH0DBHfe2tTQ9DwfA57boynd/BwGEapEKLEflMW4?=
 =?us-ascii?Q?AC2Uze2vB2+2vI4ANjKwRPPB3otdi382ngJit19AFfisSci3g7FgThaAkuEB?=
 =?us-ascii?Q?g3dbKNwA3vNIbxzI4ZSA3dm3FTHC1XLNX12sNElgkkYfQqJryr0QiZ8IivyA?=
 =?us-ascii?Q?2+gEfqtt7LvNVHbBChPdzUFWVxhStgxdGk0xxNyWK8QKoD/19sTyTi5LueZ3?=
 =?us-ascii?Q?liNfxbIhHKeyGBwxs2sqdQPQ5La+56kAuIMA4dX37fKTL4WlL+ztnhZhMCwy?=
 =?us-ascii?Q?WeHkDHY7e/+q3aJZZv2gLiA16opQaipdz4/oC+QB5lYzFT8g53wigAjUegdV?=
 =?us-ascii?Q?ZIFrtKo7p7rJTtTiNZXQJ0NbB5F4NAgCGkKWo4d+N6c+b3HnaVWKXT25C9Hq?=
 =?us-ascii?Q?iOac7jj5rSYmn1JyXskM603rBOmw2VeRLcwgGS8VUadpR0jrcmBxNc7+hT9w?=
 =?us-ascii?Q?vTO82fLdqYx7PoNQxfyQdS9wOCSZLw7qTzfLaOK0LHRlsG+YVsoQi+hrbTpv?=
 =?us-ascii?Q?u1an7ikNGHk9FjYvhEgGrT/RAWKxowJnSv/aBXP9qvMV6TbNZUzFdNihI+6W?=
 =?us-ascii?Q?kLrQWNYBuy3BngNxdEMObazGH5r+CtRiRarkLnTzQIMBcxQqLo/1cjadaYaQ?=
 =?us-ascii?Q?GaeRczyVhk4lNSXPifoT05EH5H2f6IeWLX6VH3DZiOTaplh9VQhqL1CprRTy?=
 =?us-ascii?Q?up+vcCcXTWa7KzhsD2liIg2gyQDEu8hjAF6dlxkMkw2taqkPYi4Ja3NixCYb?=
 =?us-ascii?Q?Oc/l9qKmJQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3089e193-493f-4c64-c96e-08da34248a63
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 14:34:37.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axBiQ2dQGRBF4DRRBk/w8TbkqYSvKH+3r3lucmhXGS02Qvw97xQmGuDyyhtFC0l0QVsmAgggspUtw/ckRqYAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 11, 2022 at 12:34:58PM +0200, Borislav Petkov wrote:
> On Mon, May 09, 2022 at 02:55:20PM +0000, Yazen Ghannam wrote:
> > @@ -3287,26 +3276,12 @@ static void decode_umc_error(int node_id, struct mce *m)
> >  /*
> >   * Use pvt->F3 which contains the F3 CPU PCI device to get the related
> >   * F1 (AddrMap) and F2 (Dct) devices. Return negative value on error.
> > - * Reserve F0 on systems with a UMC.
> >   */
> >  static int
> >  reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
> >  {
> > -	if (pvt->umc) {
> > -		pvt->F0 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
> > -		if (!pvt->F0) {
> > -			edac_dbg(1, "F0 not found, device 0x%x\n", pci_id1);
> > -			return -ENODEV;
> > -		}
> > -
> > -		if (!pci_ctl_dev)
> > -			pci_ctl_dev = &pvt->F0->dev;
> > -
> > -		edac_dbg(1, "F0: %s\n", pci_name(pvt->F0));
> > -		edac_dbg(1, "F3: %s\n", pci_name(pvt->F3));
> > -
> > +	if (pvt->umc)
> 
> I don't like the sprinkling of those checks everywhere. And
> hw_info_get() has those checks too. I think it would be cleaner if
> hw_info_get() would call a df-specific function for fam 0x17 and later
> and do the setup there cleanly:
> 
> hw_info_get:
> 
> 	if (pvt->fam >= 0x17)
> 		return hw_info_get_df(pvt);
> 
> and so on.
> 
> Btw, I completely agree with leaving the old code as it is.
> 
> And I obviously like the code removal, ofc.
> 
> :-)
>

Okay, will do.

Also, there are five function pointers that are created in this patchset and
called from hw_info_get(). I think those pointers can be dropped and the
helper functions called from hw_info_get(). So I think it'd be good to make
hw_info_get() into a function pointer which gets set to a functoin that calls
the right collection of legacy, modern, and GPU helper functions. How does
that sound?

Thanks!

-Yazen
