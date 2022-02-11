Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7954B312D
	for <lists+linux-edac@lfdr.de>; Sat, 12 Feb 2022 00:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiBKXUP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 18:20:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKXUO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 18:20:14 -0500
X-Greylist: delayed 1727 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 15:20:11 PST
Received: from eos.fwall.u-szeged.hu (eos.fwall.u-szeged.hu [160.114.120.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F5CEC
        for <linux-edac@vger.kernel.org>; Fri, 11 Feb 2022 15:20:11 -0800 (PST)
Received: from esym.intra ([192.168.105.4] helo=esym.fwall.u-szeged.hu)
        by eos.fwall.u-szeged.hu with esmtp (Exim 4.94.2)
        (envelope-from <tibor.gyori@chem.u-szeged.hu>)
        id 1nIel6-009CI0-Kd
        for linux-edac@vger.kernel.org; Fri, 11 Feb 2022 23:51:20 +0100
X-AuditID: a07278f7-3efff7000000255f-dd-6206e868ec15
Received: from eos.fwall.u-szeged.hu (eos.intra [192.168.105.3])
        by esym.fwall.u-szeged.hu (Symantec Messaging Gateway) with SMTP id 5F.88.09567.868E6026; Fri, 11 Feb 2022 23:51:20 +0100 (CET)
Received: from sol.cc.u-szeged.hu ([160.114.8.24])
        by eos.fwall.u-szeged.hu with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <tibor.gyori@chem.u-szeged.hu>)
        id 1nIeb3-009BFK-17
        for linux-edac@vger.kernel.org; Fri, 11 Feb 2022 23:40:58 +0100
Received: from apache by sol.cc.u-szeged.hu with local (Exim 4.80.1)
        (envelope-from <tibor.gyori@chem.u-szeged.hu>)
        id 1nIeb4-0005T6-Fb
        for linux-edac@vger.kernel.org; Fri, 11 Feb 2022 23:40:58 +0100
Received: from prot7.chem.u-szeged.hu (prot7.chem.u-szeged.hu
 [160.114.21.217]) by webmail.u-szeged.hu (Horde Framework) with HTTP; Fri,
 11 Feb 2022 23:40:58 +0100
Message-ID: <20220211234058.81443i8317qnq77e@webmail.u-szeged.hu>
Date:   Fri, 11 Feb 2022 23:40:58 +0100
From:   tibor.gyori@chem.u-szeged.hu
To:     linux-edac@vger.kernel.org
Subject: Meaning of negative memory_channel value in rasdaemon message
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-2;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.3.11)
X-SZTE-local: YES
X-SZTE-HU-local: YES
X-Brightmail-Tracker: H4sIAAAAAAAAA11TfVAUdRjmd3t3LNctLsfXy4EIqw4TXyoYY0UFM6ZO5KRM0BQm7sVyd3oc
        eHsXH9IIBI0DKB/6B5wkGCRgCHllwSRlp4IQMDqhUZagiAKBKCjKOFztcnwc/vd73+d9nvfj
        2cUx2RcOclyt1TM6La2hxBLhhTo1FqQaFivWf5nntelqZ5YgAm2bMnnvQB9JwhMYjfpTRrfu
        zT0SlelGlzilH0/L7ZoUZ6Ec+3zkgAO5EVqacwX5SILLSDMC49i4vTU4JYDjPbdF1qAbwU8N
        F+bLahFMVPyCeD5BRkJP22kB/xaSa+FyVsmcrpikoKJmVJyPcNyF9Ian2X582pncAlX9xSIr
        1Qk6yu8K+TdG7oCmz1uEfDlGekKtBbemV8GP4xUYn3YlN0H9CMM/gWNWVzha53eBqpFRQTFy
        MtpoGm00jUuaRhvNKiQ8jdwYNj0pODGV1miCDUFsBqNkEoJVBhPi7lqlS3vajGa6p4PNSIAj
        M4rBBZScOCYZ/VjmrEhOSFfRrCqeNSiS1CyrTtZSrkR0m1ghc1zEdAYNw1LexJQfl3a3obAp
        6k/UyQY23qDTcDfHMcqFqOsTKWREAp2eweiSrVQz8sSFlDshu14YKyOVtJ7ZxzApjG4B3Y3j
        1EoC2dnZydx03OhpiWoN913YzgRE5D2uuZMtbB3Ll5C/zCHy5cTlkwlwBzOKxqWUh7WLjE2h
        k1i10raDC+Fzm9MhFiCr+koCeHW3JYKtcidicXPrjVYMPz9xsxWTCbXJWkbuRTzexnFceY7K
        oF2+idydaLrPoaQNOtdK7kNc12MKmccymm03as5MHEbRNMIRd5KjvIVO3D/0wirOxJVbXAvp
        PGLdxIvw4TdxXSy3lQ6p4RTJIyIo+YGF8t4hCZQ9mZKC5dTPBHR0nlkBN3OqneDs9CFnGK75
        3RW+qj67Cs6fzAmE5/UTQWAxDQXD1dKvQ6Dvt94QnhYKpZ2WjVBwqDKMD1+D3nrTW9BoKowE
        S9nIe2Bpnt0Jdb9OR0P5nZEY6LrYGAv//VMcB7nfPI/jGJY46JrN2w0tuW00PBu4r4SZP7JV
        o5yJgiUT9fSLm7sQiYVzJs5DCybKrSYuEmx3l2cJwh99mJh0WdByrfio/YzHXtmTKFOx5BoZ
        XzCx1+/9wL/8RWsPet2RdvjnYe8kGQcyugtPRoWVto/FBGZm7InbF3Xp35aeASURrvB2zOzX
        v3JwMCj2pVdfP/CIiqTXNR94Y7Zo9NmDgP29oc7bV7cMP3Q0NGJh53ZRJzqOFEhTt++coEUj
        rHLz4He1jyN8x/3/fvB2woq2Zt2ZvtQrGwZntea7t4rCvw8dCsN6yMP6D3zH4LOmlHZizcVL
        8l3vppeds/OUivM9qclv/2zfsrnhOLlVkap1LHLa390bguxM4oaSiGOrQwMCErKUlffW5Fau
        f1jZP1ZonozMD5zcWtMWOpOdmXqCErIqeoM/pmPp/wGT3e/3mQUAAA==
X-SZTE-AVcheck: YES
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear EDAC list,

when rasdaemon reports a memory error, what does it mean for the  
memory_channel value to be negative?

Example:
Feb 11 22:34:40 CRD-MILAN-3 rasdaemon[918]:            <...>-42552  
[001]     0.007845: mce_record:           2022-02-11 22:34:40 +0100  
Unified Memory Controller (bank=18), status= 9c2040000000011b,  
Corrected error, no action required., mci=CECC, mca= DRAM ECC error.
Feb 11 22:34:40 CRD-MILAN-3 rasdaemon[918]:  Memory Error 'mem-tx:  
generic read, tx: generic, level: L3/generic',  
memory_channel=-1,csrow=3, cpu_type= AMD Scalable MCA, cpu= 1,  
socketid= 0, misc= d01a0c7b01000000, addr= 2fa07780, synd=  
e4da80000a800603, ipid= 9600350f00, mcgstatus=0, mcgcap= 118, apicid= 1

Is -1 a magic value for memory_channel? On the AMD Milan platform, I  
would expect that memory channels would be numbered from 0 to 7. I  
googled for a bit, but could not find where this sort of stuff would  
be documented.

Best,
Tibor

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

