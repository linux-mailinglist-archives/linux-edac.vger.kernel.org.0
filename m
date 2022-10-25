Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0246D60D4AC
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJYT2n (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Oct 2022 15:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJYT2l (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Oct 2022 15:28:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DEDD018F;
        Tue, 25 Oct 2022 12:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 350B9B81E85;
        Tue, 25 Oct 2022 19:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E95C433D6;
        Tue, 25 Oct 2022 19:28:35 +0000 (UTC)
Date:   Tue, 25 Oct 2022 15:28:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <20221025152847.32788cd4@gandalf.local.home>
In-Reply-To: <Y1glfOlFE90SqjV/@zn.tnic>
References: <YtVlNrW58cFmksln@zn.tnic>
        <YukW/IltcCRwvSM4@yaz-fattaah>
        <Y1a4prRIYNw8GIkm@zn.tnic>
        <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
        <Y1b15vnE/Pd1U4r8@zn.tnic>
        <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <Y1cCU9UqGG7nl8cy@zn.tnic>
        <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <SJ1PR11MB6083A794C876D6F44E530CAFFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <Y1gQQ8gh1CJf0Tuy@yaz-fattaah>
        <Y1glfOlFE90SqjV/@zn.tnic>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 25 Oct 2022 20:05:48 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Oct 25, 2022 at 04:35:15PM +0000, Yazen Ghannam wrote:
> > I think the "right way" to use tracepoints is to parse the data according to
> > the format provided by the tracepoint itself. You can see an example of
> > rasdaemon doing that here:
> > https://github.com/mchehab/rasdaemon/blob/c2255178a49f62c53009a456bc37dd5e37332f09/ras-mce-handler.c#L386  
> 
> Lemme add Rostedt.
> 
> So now we have libtraceevent and here's an example how to do it:

Yes, I'm really grateful to Mauro for adapting an earlier version of
libtraceevent, although it was just cut and pasted into rasdaemon. But it
is time to use the official library, which had a bit of changes to the
interface.

> 
> https://patchwork.kernel.org/project/linux-trace-devel/patch/20221021182345.092cdb50@gandalf.local.home/
> https://www.trace-cmd.org/Documentation/libtracefs/libtracefs-kprobes.html
> 
> Reportedly, rasdaemon is still using the old libtraceevent method. So it
> probably should be updated to use the new library version.

Definitely.

> 
> > A tracepoint user should not assume a fixed struct layout, so adding
> > and rearranging fields shouldn't be a problem. I'm not sure about
> > removing a field. It seems to me that this should be okay in the
> > interface, and it's up to the application how it wants to handle a
> > field that isn't found.  
> 
> >From looking at the examples, I think the new libtraceevent should be  
> able to handle all that just fine.

As long as the code can handle a field removed or renamed. It allows the
application to check if it is there or not.

> 
> > Another option could be to define a new tracepoint.  
> 
> Yeah, no. Let's get this one to work pls.

You can always add a trace event on top of an existing trace event with a
"custom" trace event.

See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/trace_events/trace_custom_sched.h

Also, take a look at some of the code that is coming with libtracefs:

  https://patchwork.kernel.org/project/linux-trace-devel/list/?series=688772

 (Note, it's not there just yet)

Basically you can just do:

	instance = tracefs_instance_create(TOOL_NAME);

	for (i = 0; i < nr_cpus; i++) {
		tcpus[i] = tracefs_cpu_open(instance, i, false);

And then you can read from the raw trace buffers;

	/* Read all "ras" events */
	tep = tracefs_local_events_system(NULL, "ras");

	/* Note pevent was renamed to tep */

	/* I need to write up kbuffer man pages :-/ */
	kbuf = kbuffer_alloc(sizeof(long) == 8, !tep_is_bigendian());

	/* I guess you want to retrieve any data */
	tracefs_instance_file_write(instance, "buffer_percent", "0");

	buf = malloc(tracefs_cpu_read_size(tcpu));

	/* false means block until there's data */
	tracefs_cpu_read(tcpus[i], buf, false);

	struct tep_record *record;
	unsigned long long ts;

	/* Load the read raw data into the kbuffer parser */
	kbuffer_load_subbuffer(kbuf, buf);

	for (;;) {
		record.data = kbuffer_read_event(kbuf, &ts);
		if (!record.data)
			break;
		record.ts = ts;

		process(tep, record);

		kbuffer_next_event(kbuf, NULL);

		/* There's tracefs iterators that do this too, but I'm
		 * working on adding more features to them. */
	}


static void process(struct tep_handle *tep, struct tep_record *record)
{
	static struct tep_event *mc_event;
	static struct tep_event *aer_event;
	[..]
	static struct trace_seq s;
	struct tep_event *event;
	unsigned long long val;

	/* Initialize the static events to use them for data */
	if (!mc_event) {
		trace_seq_init(&s);
		mc_event = tep_find_event_by_name(tep, "ras", "mc_event");
		/* Do error checking? */
		aer_event = tep_find_event_by_name(tep, "ras", "aer_event");
		[..]
	}

	/* Remove any previous strings in s. */
	trace_seq_reset(&s);

	event = tep_find_event_by_record(tep, record);
	if (event->id == mc_event->id) {
		tep_get_field_val(&s, event, "address", record, &val, 0);
		[..]
	}
}


With libtracefs and libtraceevent, process trace events is so much easier
than it use to be!

-- Steve
